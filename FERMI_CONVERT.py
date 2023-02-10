import sys
from decimal import Decimal

mat = []  # real numbersを入れるリスト


##数字の行を配列に焼き直すブロック
with open('ENERGY_MESH.dat', 'r', encoding='utf-8') as fin:  # ファイルを開く
    for line in fin.readlines():  # 行を読み込んでfor文で回す
        row = []
        toks = line.split(' ')
        for tok in toks:
           try:
              num = float(tok)  # 行をfloatに変換する
           except ValueError as e:
              print(e, file=sys.stderr)  # エラーが出たら画面に出力
              continue

           row.append(num)  # 変換した整数をリストに保存する
        mat.append(row)


F = open('FERMI_ENERGY.log', 'r', encoding='utf-8') 
FERMI = float(F.read()) 
#print(FERMI+1)
F.close()

#print("The sum of Free enrgy(F) and kinetic(Ek) is below")

#print("mat", mat)
N = 0
temp1 = []
for i in range(len(mat)):
  temp2 = []
  for j in range(len(mat[0])):
      N = mat[i][0] - FERMI
      #temp2.append(sum(mat[i]))
  temp1.append(N)
  N = 0
  #temp2.append(mat[i][0])
  #print(mat[i][0])
#print("Energy",temp1)

###１つ目のブロックから求めたF+Ekのエネルギーの配列（２ブロック）から再度、数字の行に焼き直すブロック
###outputはshellに渡す
#print("Energy (eV)      up_DOS down_DOS integrated_up_DOS. integrated_down_DOS")
for i in range(len(mat)):
  print('{:>12g}'.format(mat[i][0]), "          ",'{:>12g}'.format(temp1[i]))
  #print('{:>12g}'.format(temp1[i]), "          ",'{:>12g}'.format(mat[i][1]), '{:>12g}'.format(mat[i][2]), '{:>12g}'.format(mat[i][3]), '{:>12g}'.format(mat[i][4])) #Right adjustied
