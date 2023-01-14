import os

dict = {}

gedFile = open("./Pavlovs.ged", "r", encoding='UTF-8')
prologFile = open("./Pavlovs.pl", "w", encoding='UTF-8')

for i in gedFile:

    w = i.split(" ") 
    
    if len(w) >= 3:
        if len(w[2]) == 0:
            w[2]  = w[3]
        if w[2][0] == "I":
            k = w[1]         
        elif w[1] == "GIVN":
            name = w[2]
        elif w[1] == "SURN":
            surnname = w[2]
            dict.update({k:(name[:-1], surnname[:-1])})
        elif w[1] == "HUSB":
            husb = w[2]         
            for k, (name, surnname) in dict.items():               
                if k == husb[:-1]:
                    dad = name + " " + surnname                   
        elif w[1] == "WIFE":
            wife = w[2]           
            for k, (name, surnname) in dict.items(): 
                if k == wife[:-1]:
                    mom = name +" "+ surnname                   
        elif w[1] == "CHIL":
            child = w[2]
            for k, (name, surnname) in dict.items(): 
                if k == child[:-1]:
                    children = name + " " + surnname            
            prologFile.write("parents(%r, %r, %r).\n" % (children, dad, mom))
            
gedFile.close()
prologFile.close()