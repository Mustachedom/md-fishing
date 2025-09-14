Lang = {}

Lang.Info = {
    currency = '$',
    fishBuyer = 'Acheteur de Poissons',
    fishShop = 'Boutique de Pêche',
    breakDown = 'Décomposition des Matériaux',
    yes = 'Oui',
    no = 'Non',
}

Lang.Fails = {
    tooFar = ' %s était trop loin de %s',
    invalidItem = ' %s a tenté d’acheter un objet invalide | %s | chez %s',
    invalidBreakdown = ' %s a tenté de décomposer un objet invalide | %s | chez %s',
    tooPoor = 'Vous n’avez pas %s %s dans %s',
    zoneGlitch = '%s a déclenché md-fishing:server:inZone mais n’était pas dans les coordonnées de la zone',
    leftZone = 'Vous avez quitté la zone de pêche pendant que vous pêchiez !',
    onTimeout = 'Vous pêchez un peu trop vite, les poissons ont peur !',
    outOfBait = 'Vous êtes à court d’appâts',
    inVehicle = ' Vous ne pouvez pas pêcher dans un véhicule !',
    alreadyFishing = 'Vous êtes déjà en train de pêcher !',
    failedCatch = 'Tant pis, il y a d’autres poissons dans la mer'
}

Lang.Labels = {
    fishZoneBlip = 'Zone de Pêche',
    illegalFishzoneBlip = 'Zone de Pêche Illégale',
    fishBuyerBlip = 'Acheteur de Poissons',
    chumMakerBlip = 'Fabricant d’Appâts',
    shopLocationBlip = 'Boutique de Pêche',
    breakDownBlip = 'Décomposition des Matériaux',
}

Lang.Shops = {
    sold = 'Vous avez vendu %s de %s pour %s %s',
    noFish = ' Vous n’aviez aucun %s à vendre',
    bought = 'Vous avez acheté %s de %s pour %s %s',
}

Lang.Fishing = {
    stopped = 'Vous avez arrêté de pêcher',
    notInZone = 'Vous n’êtes pas dans une zone de pêche',
    wrongPole = 'Vous ne pouvez pas utiliser cette canne ici',
    noLevel = 'Vous n’avez aucune donnée de pêche, veuillez vous reconnecter',
    wrongLevel = 'Vous devez être niveau %s pour pêcher ici',
    found = 'Vous avez une touche !',
    inZone = 'Vous êtes maintenant dans une zone de pêche',
    outZone = 'Vous êtes maintenant hors de la zone de pêche',
}

Lang.Targets = {
    fishBuyer = {
        label = 'Vendre vos poissons',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Tout vendre',
            icon = 'fas fa-donate',
            description = 'Vendez tous vos poissons d’un coup !'
        },
        description = 'Vendre pour ' .. Lang.Info.currency .. '%s l’unité',
        menuTitle = 'Vendre des Poissons'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Parcourir la boutique',
        input = {
            title = 'Acheter %s',
            field1title = 'Combien acheter ?',
            field2title = 'Type de paiement',
            field2option1 = 'Espèces',
            field2option2 = 'Banque',
        },
        menuTitle = 'Boutique de Pêche'
    },
    chumMaker = {
        label = 'Fabriquer de l’appât',
        icon = 'fas fa-shopping-basket',
        description = 'Fabriquez de l’appât pour la pêche',
        input = {
            title = 'Confirmer la fabrication d’appât',
            field1title = 'Confirmer',
            description = 'Cela supprimera tous vos poissons'
        },
        menuTitle = 'Fabriquer de l’Appât'
    },
    breakDown = {
        label = 'Décomposition des Matériaux',
        icon = 'fas fa-dumpster-fire',
        description = 'Décomposez les objets en matériaux',
        input = {
            description = 'Décomposer %s en matériaux',
        },
        menuTitle = 'Décomposition des Matériaux',
        progressbar = 'Décomposition de %s en cours'
    }
}

Lang.anchor = {
    notInWater = 'Le bateau n’est pas dans l’eau !',
    unanchored = 'Vous avez levé l’ancre de votre bateau',
    anchored = 'Vous avez jeté l’ancre de votre bateau',
    noBoat = 'Où est votre bateau ?',
}

return Lang