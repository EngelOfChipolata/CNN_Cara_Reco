# La classe PhotoImage du module Tkinter, que vous avez déjà 
# utilisé et qui est installé, permet de charger une image 
# au format .gif et .pgm.
# Voir l'exemple ci-dessous. Attention selon les versions de 
# Tkinter la fonction get(i,j) renvoie un tuple (nouvelle version) 
# ou une chaine de caratères (ancienne version). La version dans 
# les salles est la seconde, semble-t-il, il faut donc transformer 
# manuellement la chaine de carateres en tuple comme dans l'exemple.
# Attention pour les images en niveau de gris la fonction get(i,j) 
# renvoie un tuple (ou une chaine de carateres) de trois entiers
# de type RGB (Red,Green,Bleu) avec trois fois la même valeur i.e.
# tel que (Gray,Gray,Gray)

import tkinter, sys
 
def get_matrix(file):
    img = tkinter.PhotoImage(file=file)
    print('nb lignes = {}\nnb colonnes = {}'.format(img.width(), img.height()))
    return [[ #img.get(c, l)
              tuple(map(int, img.get(c, l).split())) # transforme la chaine de carateres en tuple  
             for c in range(img.width())] 
            for l in range(img.height())]

def main():
    top = tkinter.Tk()
    file = sys.argv[1] #file = 'smiley.gif'
    matrix_img = get_matrix(file)
    print(matrix_img)

main()
