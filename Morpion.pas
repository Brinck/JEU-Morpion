program Morpion (input, output);

uses crt;

type
        TCase=record //Enregistrement du type TCase pour la structure des cases
                CoordX:integer;//Coordonnee en x de la case
                CoordY:integer;//Coordonnee en y de la case
                Numero:integer;//Numero de la case
                Rempli:boolean;//Indique si la case est deja remplie ou non
                Signe:string;//Indique le caractere entre dans la case si elle est remplie
        end;

type
        TPlateau=Array[1..9] of TCase; //Le plateau est compose de cases

type
        TPlayer=record //Enregistrement du type TPlayer contenant les parametres qui definissent un joueur
                NumPlayer:integer;//Numero du joueur
                SignePlayer:string;//Signe du joueur
        end;

//BUT : Creation des joueurs
//ENTREE : Pas d'entree
//SORTIE : Joueurs correctement definis
procedure CreatPlayer(P1,P2:TPlayer);
        begin
        //Joueur 1
        P1.NumPlayer:=1;
        P1.SignePlayer:='X';

        //Joueur 2
        P2.NumPlayer:=2;
        P2.SignePlayer:='O';
        end;

//BUT : Creation des cases du morpion
//ENTREE : Pas d'entree
//SORTIE : Cases creees et correctement structurees
procedure CreatCases(var Plateau:TPlateau);
        begin
        //Case 1
        Plateau[1].CoordX:=1;
        Plateau[1].CoordY:=1;
        Plateau[1].Numero:=1;
        Plateau[1].Rempli:=FALSE;

        //Case 2
        Plateau[2].CoordX:=3;
        Plateau[2].CoordY:=1;
        Plateau[2].Numero:=2;
        Plateau[2].Rempli:=FALSE;

        //Case 3
        Plateau[3].CoordX:=5;
        Plateau[3].CoordY:=1;
        Plateau[3].Numero:=3;
        Plateau[3].Rempli:=FALSE;

        //Case 4
        Plateau[4].CoordX:=1;
        Plateau[4].CoordY:=3;
        Plateau[4].Numero:=4;
        Plateau[4].Rempli:=FALSE;

        //Case 5
        Plateau[5].CoordX:=3;
        Plateau[5].CoordY:=3;
        Plateau[5].Numero:=5;
        Plateau[5].Rempli:=FALSE;

        //Case 6
        Plateau[6].CoordX:=5;
        Plateau[6].CoordY:=3;
        Plateau[6].Numero:=6;
        Plateau[6].Rempli:=FALSE;

        //Case 7
        Plateau[7].CoordX:=1;
        Plateau[7].CoordY:=5;
        Plateau[7].Numero:=7;
        Plateau[7].Rempli:=FALSE;

        //Case 8
        Plateau[8].CoordX:=3;
        Plateau[8].CoordY:=5;
        Plateau[8].Numero:=8;
        Plateau[8].Rempli:=FALSE;

        //Case 9
        Plateau[9].CoordX:=5;
        Plateau[9].CoordY:=5;
        Plateau[9].Numero:=9;
        Plateau[9].Rempli:=FALSE;

        end;

//BUT :  Affichage du plateau de jeu
//ENTREE : Pas d'entree
//SORTIE : Plateau de jeu correctement affiche
procedure AffPlateau;
        var
                x,y:integer;
                compteur:integer; //Permet d'afficher le numero des cases

        begin
        //Initialisation du compteur a 1
        compteur:=1;

        //Boucle d'affichage du tableau
        //Passage de lignes en lignes
        FOR y:=1 TO 5 DO
                begin
                //Passage de cases en cases
                FOR x:=1 TO 5 DO
                        begin
                        //Place le pointeur aux coordonnees definies par la boucle
                        GoToXY(x,y);

                        //Si les coordonnees sont paires on affiche le caractere de la grille
                        IF ((x MOD 2 = 0) OR (y MOD 2=0)) THEN
                                begin
                                write('*');
                                end
                        //Sinon affiche le numero de la case
                        ELSE
                                begin
                                write(compteur);
                                compteur:=compteur+1;//Incrementation du compteur
                                end;
                        end;
                end;
        end;

//BUT : Proposer au joueur de choisir une case dans laquelle il veut mettre son signe
//ENTREE : la case choisie du joueur
//SORTIE : Le signe s'inscrit dans la case ou affiche un message en cas d'erreur
procedure ChoixJoueur(var Plateau:TPlateau;var Tour:integer; P1,P2:TPlayer);
        var
                choix:integer; //Choix du joueur
        begin
        //Boucle de choix
        REPEAT
                //Boucle d'instruction
                REPEAT
                        //Place le pointeur en dessous du plateau et vide la ligne si elle est deja remplie
                        GoToXY(1,9);
                        write('                                                                                                ');

                        //Instruction
                        GoToXY(1,9);
                        write('Veuillez entrer le numero de la case que vous souhaitez remplir : ');
                        readln(choix);

                        //Affichage du message d'erreur si le joueur entre un nombre non compris entre 1 et 9
                        IF ((choix<1)OR(choix>9)) THEN
                                begin
                                //Place le pointeur au dessus de la phrase et vide la ligne si elle est deja remplie
                                GoToXY(1,8);
                                write('                                                                                                ');

                                //Message d'erreur
                                GoToXY(1,8);
                                write('/!\ Vous n''avez pas mis un chiffre entre 1 et 9 /!\');
                                end;

                UNTIL ((choix>=1)AND(choix<=9)); //Jusqu'a ce que le joueur ait entre un chiffre entre 1 et 9

                IF Plateau[choix].Rempli=TRUE THEN
                        begin
                        //Place le pointeur au dessus de la phrase et vide la ligne si elle est deja remplie
                        GoToXY(1,8);
                        write('                                                                                                ');

                        //Message d'erreur
                        GoToXY(1,8);
                        write('/!\ Vous n''avez pas mis un chiffre entre 1 et 9 /!\');
                        end;
        UNTIL (Plateau[choix].Rempli=FALSE); //Jusqu'a ce que le joueur ait choisi une case vide

        //On place le pointeur sur la case associee au choix
        GoToXY(Plateau[choix].CoordX,Plateau[choix].CoordY);

        //On insere le signe associe au joueur
        //Tour pair = Joueur 2 ( X )
        IF (Tour MOD 2 = 0) THEN
                begin
                write(P2.SignePlayer);
                Plateau[choix].Signe:=P2.SignePlayer;
                end
        //Tour impair = Joueur 1 ( O )
        ELSE
                begin
                write(P1.SignePlayer);
                Plateau[choix].Signe:=P1.SignePlayer;
                end;

        //On indique que la case est remplie desormais
        Plateau[choix].Rempli:=TRUE;

        //On vide la ligne ou sont marquees les erreurs
        GoToXY(1,8);
        write('                                                                                                ');

        end;

//BUT : Faire le tour de jeu
//ENTREE : Pas d'entree
//SORTIE : Changement de tour, insertion du signe dans la case que le joueur a choisi s'il en choisi une valide ou affiche un message d'erreur
procedure TourDeJeu(var Plateau:TPlateau;var Tour:integer; P1,P2:TPlayer);
        begin
        //Initialisation du numero du tour a 1
        Tour:=1;

        //Boucle de jeu
        REPEAT
                //Le joueur entre son choix
                ChoixJoueur(Plateau,Tour,P1,P2);

                //Incrementation du numero du tour
                Tour:=Tour+1;
        UNTIL(Tour=9);
        end;

//PROGRAMME PRINCIPAL
var
        Plateau:TPlateau; //Plateau compose de cases
        Tour:integer; //Numero du tour
        P1,P2:TPlayer; //Joueur 1 et 2

BEGIN
        //Message de depart
        clrscr;
        writeln('Programme : jeu du Morpion');
        writeln('Appuyez sur ''entrer'' pour lancer la partie');
        readln;
        clrscr;

        //Creation des joueurs
        CreatPlayer(P1,P2);

        //Creation des cases du plateau de jeu
        CreatCases(Plateau);

        //Affichage du plateau
        AffPlateau;

        //Tour de jeu
        TourDeJeu(Plateau,Tour,P1,P2);

        readln;

END.
