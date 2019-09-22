# NLPF

## Liens importants :
- [Mojolicious Wiki](https://github.com/mojolicious/mojo/wiki)
- [Mojolicious Database support](https://github.com/mojolicious/mojo/wiki/Database-support)
- [Intellij Plugin](https://plugins.jetbrains.com/plugin/7796-perl)

## Installation :

1. Récupérer le fichier NLPF.ova sur le drive PIT/NLPF
2. Télécharger et installer la dernière version de VirtualBox (https://www.virtualbox.org/wiki/Downloads)
3. Exécuter VirtualBox et aller dans fichier puis Importer.
4. Sélectionner le fichier NLPF.ova puis lancer l'importation
5. Une fois fini, cliquer sur la machine importée et aller dans configuration -> Dossiers partagés
6. Editer le dossier partagé et choisissez un dossier s'appelant NLPF/ (si vous n'en avez pas créer-le) et mettez comme point de montage /home/nlpf/NLPF
7. Lancer la machine
8. Aller dans le dossier ~/NLPF
9. Lancer la commande
```Bash
git clone https://github.com/TotonioR/NLPF.git
```
10. Aller dans le dossier cloné
11. Exécuter ./start.sh pour lancer le serveur web
12. Sur Windows, ouvrez votre navigateur web et allez sur la page 127.0.0.1:3000
13. Lancez votre IDE ou votre éditeur de texte sur Windows et allez dans le dossier que vous avez précédemment créé lors de l'étape 6
14. Commencez à coder
