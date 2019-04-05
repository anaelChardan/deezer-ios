# Test technique Deezer

[![Language](https://img.shields.io/badge/Swift-5.0-brightgreen.svg)](http://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-10.2-brightgreen.svg)](https://developer.apple.com/download/more/)

## ✉️ Informations de contact

- Nom : Maxime Maheo
- Email : maxime.maheo@gmail.com
- LinkedIn : [Lien](https://www.linkedin.com/in/maxime-maheo-120907a8/)

## ⏱ Temps passé
Entre 14h et 20h.

## 🏛 Architecture

J'ai choisi d'utiliser une architecture MVVM plutôt qu'une architecture VIPER qui serait trop compliqué pour un projet de cette taille.
L'utilisation des delegates pour prévenir la mise à jour est utilisé pour maintenir la compatibilité entre le Swift et l'Objective-c. Cependant, le dynamic binding peut être utilisé mais on perd la similarité entre le code Objective-c (Delegate) et Swift (Dynamic bindings). Un exemple de classe dynamic est en [annexe 1](#annexe-1)

## 🚅 Optimisations diverses

- Mise en cache (mémoire) des images. Elles ne sont pas retéléchargées si elles sont dans le cache
- Quand on cherche un artiste, au lieu de faire une requête au serveur dès que le nom de l'artiste a changé, on va regarder toutes les 500ms si le texte de recherche est différent de la dernière recherche envoyé au serveur. Cela permet de réduire drastiquement le nombre de recherche envoyé au serveur (économisation de batterie). De plus, correspond plus à l'utilisation souhaité, envoyer la requête quand l'utilisateur a finit de taper le nom de l'artiste.
- L'application est disponible en Français et en Anglais.
- Toutes les requêtes réseaux sont éxécutés dans un thread en background. Le reste du code est éxécuté dans le thread UI.
- Chargement des images HD pour les artistes populaires, sinon en SD pour les autres artistes.
- Tests unitaires pour les models et les services.
- Test UI pour vérifier que le flow de l'application correspond à celui qui est souhaité.

## 👍 Bonnes pratiques

- Utilisation des protocols pour exposer que les methodes souhaitées.
- Utilisation du type `Result` de Swift 5.0 pour les requêtes réseaux.
- Utilisation de Singleton pour avoir le code centralisé (notament le réseau, le player de music et la gestion du cache).
- Ajout de la documentation Apple pour les méthodes et les propriétés.
- Utilisation des storyboards uniquement pour le placement des composants. Le design des composants est géré dans le code. Cela permet une modification de design plus rapide.

## 💡 Améliorations possibles

- Affichage d'une image en faible qualité en attedant l'image HD.
- Mise en cache des images en mémoire mais aussi en disque.
- Mise en cache des requêtes réseaux.

## Annexes

### Annexe 1

```swift
class Dynamic<T> {
    
    typealias Listener = (T) -> Void
    
    // MARK: - Properties
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }

    // MARK: - Lifecycle
    init(_ v: T) {
        value = v
    }

    // MARK: - Methods    
    func bind(listener: Listener?) {
        self.listener = listener
    }
}
```