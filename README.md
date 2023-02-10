# PDOSPLOTレポジトリーの詳細
電子状態解析に有効な手法の一種である射影状態密度（PDOS）をプロットするプログラム群

プログラム群のそれぞれの説明は以下

①PDOS_PLOT_ver7_Li.sh：
メインプログラム。

②LPDOS_SUM.py:
DOSを各原子の各原子軌道に射影したLPDOSを抽出するプログラム。メインプログラムで指定した軌道について和をとるプログラム。

③PDOS_SUM_FOR_ATOM.sh：
抽出したLPDOSをメインプログラムで指定した原子について和をを実行するshellスクリプト。

③ー１.ATOM_SUM_ALPHA.py：
PDOS_SUM_FOR_ATOM.shの副プログラムで、αスピンについて和をとるとるプログラム。

③-2.ATOM_SUM_BETA.py：
PDOS_SUM_FOR_ATOM.shの副プログラムで、βスピンについて和をとるとるプログラム。

④FERMI_CONVERT.sh：
DOSCARに記載されているDOSのエネルギーをFermiエネルギーを原点にするshellスクリプト。

④-1.FERMI_CONVERT.py：
Fermiエネルギーを原点にエネルギーメッシュをシフトするプログラム。


以下にプログラムの編集を詳細する。
①のメインプログラムで、ATOMList=( )とORBList=( )で興味のある原子と原子軌道を指定する。
それらについて状態密度を射影する。

DOSCARが同じdirectory中にあることを確認し、
bash ./PDOS_PLOT_ver7_Li.shを実行する。


