
mat = []  
## the data set for real numbers


##the lines of the numbers into the data sets
with open('temp99.txt', 'r', encoding='utf-8') as fin:  # open file
    for line in fin.readlines():  # read lines 
        row = []
        toks = line.split(  )
        for tok in toks:
           try:
              num = float(tok)  # the numbers in lines are converted into float type.
           except ValueError as e:
              print(e, file=sys.stderr)  # IF THE ERROR OCCURED, SHOW IT.
              continue

           row.append(num)  #SAVE THE FLOAT DATA SET INTO NUM
        mat.append(row)

#print("The sum of Free enrgy(F) and kinetic(Ek) is below")
#print("mat", mat)
N = 0
temp1 = []
for i in range(len(mat)):
  temp2 = []
  for j in range(len(mat[0])-1):
      N += mat[i][j+1]
      #temp2.append(sum(mat[i]))
  temp1.append(N)
  N = 0
  #temp2.append(mat[i][0])
  #print(mat[i][0])
#print("Energy",temp2)

###
### TRANSFER THE OUTPUT INTO THS PDOS_PLOT_ver*.sh
#print("Energy (eV)      DOS_sum")
for i in range(len(mat)):
  print('{:>12g}'.format(mat[i][0]), "          ",'{:>12g}'.format(temp1[i])) #Right adjustied
  #print('{:.12g}'.format(mat[i][0]), "          ",'{:.12g}'.format(temp1[i])) 

#Reference
#https://hibiki-press.tech/python/format/1015 Right adjustied
#
#

