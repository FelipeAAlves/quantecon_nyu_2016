import re
import requests
import matplotlib.pyplot as plt

class Firm(object):
    r"""
    Creates an instance of a firm that holds its characteristics and 
    has get_price method
    """
    def __init__(self, symbol, name, mktcap ):
        self.symbol, self.name, self.mktcap = symbol, name, mktcap
        
        # Indicator for LowerCap Stock < 2B
        self.bc = 1 if mktcap > 2000 else 0

    def get_price(self):
        r"""
        Ask for \% price change in yahoo
        """

        info = {'s': self.symbol, 'f': 'p2'}
        
        r = requests.get('http://finance.yahoo.com/d/quotes.csv', info)
        match = re.search(r'([+-]\d+\.?\d*)%?',r.text) 
        self.ppc = float(match.group(1)) if match else []
    

## REMAINING COMMANDS
# == Choose which dataset to Open == #
data = open('company_list_old.csv','r')
# data = open('company_list_corrected.csv','r')

next(data)
firms = []
i = 0
print_firms = False

for line in data:

    #= extract info =#
    ## Old dataset
    line = line.replace('"','')
    symbol, name, mk_cap = line.split(',')
    ## corrected dataset
    #symbol, name, mk_cap = re.split(r',(?=(?:[^"]*"[^"]*")*[^"]*$)',line)
    
    match = re.search(r'\$?(\d+\.?\d*)([MB]?)',mk_cap)
    
    if match:
        if match.group(2)=='': #
            mktcap = float(match.group(1))
        elif match.group(2)=='M':                   # if there is million in the END
            mktcap = float(match.group(1))
        elif match.group(2)=='B':                   # if there is Billion in the END 
            mktcap = float(match.group(1))*1000
    else:
        mktcap = -1.0

    print('{0:5s} {1:40s} {2:7.2f}'.format(symbol,name,mktcap)) if print_firms==True else None
    f = Firm(symbol,name,mktcap)
    
    f.get_price()
    firms.append(f)
    i+=1
    if i==100:
        break

# == extract the indices without any missing information == #
ind = []
i = 0
for f in firms:
    ind.append(i) if f.mktcap != -1.0 and f.ppc !=0.00 else None
    i+=1
ind

MC  =  [firms[i].mktcap for i in ind]
ppc =  [abs(firms[i].ppc) for i in ind]

fig, ax = plt.subplots()
ax.scatter(MC, ppc , color = 'red')
ax.set_xlabel('Market Cap')
ax.set_ylabel('% Price Change')
plt.show()