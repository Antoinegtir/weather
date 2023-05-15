# Application Météo avec Flutter

Home Page               |  Plan View              
:-------------------------:|:-------------------------:|
<img src="https://github.com/Antoinegtir/weather/blob/main/screenshot/simulator_screenshot_44AED0F6-9C49-4A52-98DC-F0259D6AB995.png?raw=true" alt="Calandar Page" width="150"/>|<img src="https://github.com/Antoinegtir/weather/blob/main/screenshot/simulator_screenshot_496D7128-215D-4B99-A70B-4514ACD3A657.png?raw=true" alt="List Page" width="150"/>

Au cours de ce Coding-club, tu vas apprendre a developper ta première application mobile réactive, créer son interface graphique, comprendre ce qu'est une API et récuperer ses données.

### Qu'est-ce que Flutter ?

<img src="https://humancoders-formations.s3.amazonaws.com/uploads/course/logo/1148/formation-flutter.png" height="150"></img>

Flutter est un framework open-source développé par Google qui permet de créer des applications multiplateformes avec une seule base de code. Il utilise le langage de programmation Dart et fournit une vaste collection de widgets prêts à l'emploi pour construire des interfaces utilisateur réactives.

## Prérequis

Avant de commencer à coder l'application météo, assurez-vous d'avoir les éléments suivants :

Flutter SDK installé sur votre machine.
VScode installé avec l'extension Flutter et JSON Beautify.

## Creation du projet

Créez un nouveau projet Flutter en utilisant la commande suivante dans votre terminal :
`flutter create my_meteo_app`

differents fichiers vont apparaitre sur votre table de travail, parmis eux le fichier
`pubspec.yaml`, celui ci permet d'installer une extensions permettant d'ajouter des paquets afin d'elargir les possibilités de developpment avec flutter.

l'extension que nous allons utiliser pour mener a bien ce projet se nomme `http` et vous permettra
ainsi d'interagir avec une api.

### Mais qu'est ce qu'une API?

<img src="https://www.planningpme.fr/img/planningpme-api.jpg"></img>

Une api (Application Programming Interface) est un ensemble de règles et de protocoles qui permettent à différentes applications informatique de communiquer entre elles.
Nous nous en servirons pour récupérer les données météorologique en temps réel!

Pour installer un package, tapez la commande `flutter pub add nom_du_package` dans le terminal.

## Familiarisation de l'espace de travail

<img src="https://blog.logrocket.com/wp-content/uploads/2022/02/main-dart-flutter-great-opener.png"></img>

Vous pouvez constater qu'il y a sur votre espace de travail plusieurs noms de système d'exploitation tel que `ios`, `android`, c'est grâce à ces dossier que le code de chaque plateforme est traité puis est ensuite compilé dans le dossier `build` qui apparaitra lors votre première compilation.

Maintenant, concentrons nous sur le dossier `lib`, dans celui ci vous trouverez le fichier `main.dart` qui est le fichier principal de l'application, c'est dedans que l'on vas pouvoir coder l'entierté de l'application.

## Lancement de l'application

<img height="250" src="https://www.emanprague.com/wp-content/uploads/2018/04/first_start.png"></img>

Dans le fichier `main.dart` se trouve du code par defaut proposé par flutter, vous pouvez desormais lancer l'application de base de flutter sur la plateforme de votre choix (dans la mesure du possible), pour cela tappez la commande `flutter run`, vous pourrez desormais chosir de compiler votre application sur Chrome, peut etre un simulateur android, ou bien votre propre téléphone si celui ci est branché à votre ordinateur. Pour selectionner quel appareil compiler l'application tapez 1, 2, 3 ou plus dans votre terminal.

Vous pouvez essayer de changer le titre de l'application dans le code dans `main.dart` en remplacant par exemple "Flutter Demo HomePage" par le titre de l'application de votre choix, une fois cela fais tapez la commande `r` pour rafraîchir les widgets de l'application, assurez vous d'avoir activé l'auto-save sur vscode.

### Qu'est ce qu'un widget?

<img  src="https://static.javatpoint.com/tutorial/flutter/images/flutter-widgets.png"></img>

Les widgets sont les éléments de base utilisés pour construire l'interface utilisateur d'une application. Un widget est une classe qui décrit la structure et l'apparence d'une partie de l'interface utilisateur, tel qu'un bouton, une image, un texte, etc... Les widgets peuvent être imbriqués les uns dans les autres pour créer une hiérarchie d'éléments d'interface plus complexes.

tu pourras comprendre comment fonctionne chaque widget grâce a la documentation suivante: 
https://api.flutter.dev/flutter/widgets/Image-class.html

## Conseil

Essayez de changer les valeurs, les ordres d'embriquements des widgets pour vous y familiariser.

Gardez à l'esprit que toutes l'interface graphique de l'application et les widgets sont placé à l'interieur des accolades de `Widget build(BuildContext context){}`.

## Procédé d'arriere plan

Tout ce qui est donc au dessus de `Widget build(BuildContext context){}` servira pour la partie arrière plan de l'application, dans l'exemple de `main.dart` proposé par flutter, 
`void initState()` est une fonction special qui permettra d'appeler la fonction `getWeather`, tu devras la developper pour récupérer les valeurs de l'api et qui nous fournira des données météorologique, s'elle ci devra etre placer au dessus de `initState`.

## Découverte de l'API

Commencons à comprendre le fonctionnement de l'api, munis toi de l'url suivant et l'insère le sur le navigateur web de ton choix: https://api.weatherapi.com/v1/current.json?key=4c1eea14200b42b38f4150701230805&q=Nantes

voici comment se décompose l'url, comme l'indique le shema ci dessous.
- Nom de domaine: "api.weatherapi.com"
- Chemin indiquant la version de l'api: "/v1"
- Demande de renvoyer les valeurs de la météo sous la forme d'un fichier "json": "/current.json?"
- "key", etant la clef d'API nous autorisant tous à bénéficier des données meteorologique
- "q=NOM_DE_TA_VILLE" te permettant de choisir dans quelle ville tu vas vouloir soutirer les données.

<img  src="https://res.cloudinary.com/practicaldev/image/fetch/s--6H1vWftu--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://blog.jordanholt.dev/wp-content/uploads/2021/08/URL-basic-syntax.png"></img>

Tu peux constater que l'url renvoie un code peu comprehensible à l'oeil humain sur le site internet, je t'invite a crée un dossier `proto` a la racine de ta table de travail avec à l'interieur un fichier `data.json` dans lequel tu pourra copier coller au caractere près tous les caractères du site internet.

une fois copié dans `data.json`, tape la commande `ctrl + shift + j`

le code est desormais plus comprehensible, on peut donc lire les données météorologique que nous allons extraire et afficher proprement sur notre application de météo. Pour cela, tu vas devoir initialiser les variables `String` (chaîne de caractères).
Pour chaque donnée que tu vas vouloir extraire, choisis s'elle que tu veux dans le json, peut etre que tu veux afficher proprement sur l'application le nom de la région, l'indice uv, l'humidité, la vitesse du vent? ou les 4 à la fois voir au dela pour une application de météo complète avec beaucoup d'informations pertinantes!

## Récuperation de la data

tu y es presque ton application de météo est bientot 100% operationnelle, plus qu'à faire une requête à l'api en créant la fonction `getWeather`, dans cette fonction tu vas devoir te munir du paquet `http` que je t'ai fais installer au debut du coding-club, tu vas pouvoir insérer l'url dans la fonction et ainsi récuperer directement tout le code json automatiquement au lieu de le copier coller à la main comme tu l'as fait quand tu as crée le fichier `data.json`.

Maintenant que tu as recuperé correctement le code json tu peux faire un print(response.body) comme en python pour t'assurer qu'il existe bien, si s'est le cas, les données que tu avais copié collé auparavant s'afficheront sur le terminal.

Une fois s'être assuré que les informations brut du json sont desormais présente, tu vas pouvoir écremer les informations grâce à la fonction `jsondecode` une fois ceci fait, invoque la fonction `setState` te permettant de remplir la `String` que tu as initialisé anterieurement vers le chemin de la clef de la variable remplis par `jsondecode`.

## Derniere ligne droite!

Il ne te reste plus qu'à afficher ta variable `String` dans un widget `Text`. Félicitations ! Tu as correctement affiché une valeur provenant d'une API, ton application de météorologie est preque finis plus qu'à t'amuser et à créer une interface graphique qui te corresponde, pourquoi pas ajouter un logo et un écran de chargement personnalisé et decouvir d'autres paquets graphique pour laisser libre cours à ton imagination !

Liens pour explorer les paquets Flutter: https://pub.dev/packages/        

Paquet écran de chargement: https://pub.dev/packages/flutter_native_splash          

Paquet logo d'application: https://pub.dev/packages/flutter_launcher_icons

PS: La clef d'API est valable jusqu'au Lundi 27 mai, tu pourras renouveler la clef en en générant une nouvelle sur le site https://www.weatherapi.com
