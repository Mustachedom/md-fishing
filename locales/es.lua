Lang = {}

Lang.Info = {
    currency = '$',
    fishBuyer = 'Comprador de Peces',
    fishShop = 'Tienda de Pesca',
    breakDown = 'Descomposición de Materiales',
    yes = 'Sí',
    no = 'No',
}

Lang.Fails = {
    tooFar = ' %s estaba demasiado lejos de %s',
    invalidItem = ' %s intentó comprar un objeto inválido | %s | de %s',
    invalidBreakdown = ' %s intentó descomponer un objeto inválido | %s | de %s',
    tooPoor = 'No tienes %s %s en %s',
    zoneGlitch = '%s activó md-fishing:server:inZone pero no estaba dentro de las coordenadas de la zona',
    leftZone = '¡Saliste de la zona de pesca mientras pescabas!',
    onTimeout = 'Estás pescando demasiado rápido, ¡los peces tienen miedo!',
    outOfBait = 'Te has quedado sin cebo',
    inVehicle = ' ¡No puedes pescar en un vehículo!',
    alreadyFishing = '¡Ya estás pescando!',
    failedCatch = 'Bueno, hay más peces en el mar'
}

Lang.Labels = {
    fishZoneBlip = 'Zona de Pesca',
    illegalFishzoneBlip = 'Zona de Pesca Ilegal',
    fishBuyerBlip = 'Comprador de Peces',
    chumMakerBlip = 'Fabricante de Cebo',
    shopLocationBlip = 'Tienda de Pesca',
    breakDownBlip = 'Descomposición de Materiales',
}

Lang.Shops = {
    sold = 'Vendiste %s de %s por %s %s',
    noFish = ' No tenías ningún %s para vender',
    bought = 'Compraste %s de %s por %s %s',
}

Lang.Fishing = {
    stopped = 'Dejaste de pescar',
    notInZone = 'No estás en una zona de pesca',
    wrongPole = 'No puedes usar esta caña aquí',
    noLevel = 'No tienes datos de pesca, por favor, vuelve a iniciar sesión',
    wrongLevel = 'Necesitas ser nivel %s para pescar aquí',
    found = '¡Tienes una mordida!'
}

Lang.Targets = {
    fishBuyer = {
        label = 'Vende tus peces',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Vender todo',
            icon = 'fas fa-donate',
            description = '¡Vende todos tus peces de una vez!'
        },
        description = 'Vender por ' .. Lang.Info.currency .. '%s cada uno',
        menuTitle = 'Vender Peces'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Explorar tienda',
        input = {
            title = 'Comprar %s',
            field1title = '¿Cuántos comprar?',
            field2title = 'Tipo de pago',
            field2option1 = 'Efectivo',
            field2option2 = 'Banco',
        },
        menuTitle = 'Tienda de Pesca'
    },
    chumMaker = {
        label = 'Fabricar cebo',
        icon = 'fas fa-shopping-basket',
        description = 'Fabrica cebo para usar como carnada',
        input = {
            title = 'Confirmar fabricación de cebo',
            field1title = 'Confirmar',
            description = 'Esto eliminará todos tus peces'
        },
        menuTitle = 'Fabricar Cebo'
    },
    breakDown = {
        label = 'Descomposición de Materiales',
        icon = 'fas fa-dumpster-fire',
        description = 'Descompón objetos en materiales',
        input = {
            description = 'Descomponer %s en materiales',
        },
        menuTitle = 'Descomposición de Materiales',
        progressbar = 'Descomponiendo %s'
    }
}

Lang.anchor = {
    notInWater = '¡El barco no está en el agua!',
    unanchored = 'Has levantado el ancla de tu barco',
    anchored = 'Has anclado tu barco',
    noBoat = '¿Dónde está tu barco?',
}

return Lang