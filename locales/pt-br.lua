Lang = {}

Lang.Info = {
    currency = 'R$',
    fishBuyer = 'Comprador de Peixes',
    fishShop = 'Loja de Pesca',
    breakDown = 'Quebrar Materiais',
    yes = 'Sim',
    no = 'Não',
}

Lang.Fails = {
    tooFar = ' %s estava muito longe de %s',
    invalidItem = ' %s tentou comprar um item inválido | %s | de %s',
    invalidBreakdown = ' %s tentou quebrar um item inválido | %s | de %s',
    tooPoor = 'Você não tem %s %s em %s',
    zoneGlitch = '%s ativou md-fishing:server:inZone mas não estava dentro das coordenadas da zona',
    leftZone = 'Você saiu da zona de pesca enquanto estava pescando!',
    onTimeout = 'Você tá pescando rápido demais, os peixes tão com medo!',
    outOfBait = 'Seu isca acabou',
    inVehicle = ' Você não pode pescar dentro de um veículo!',
    alreadyFishing = 'Você já tá pescando!',
    failedCatch = 'Poxa, tem mais peixe no mar'
}

Lang.Labels = {
    fishZoneBlip = 'Zona de Pesca',
    illegalFishzoneBlip = 'Zona de Pesca Ilegal',
    fishBuyerBlip = 'Comprador de Peixes',
    chumMakerBlip = 'Fabricante de Isca',
    shopLocationBlip = 'Loja de Pesca',
    breakDownBlip = 'Quebrar Materiais',
}

Lang.Shops = {
    sold = 'Você vendeu %s de %s por %s %s',
    noFish = ' Você não tinha nenhum %s pra vender',
    bought = 'Você comprou %s de %s por %s %s',
}

Lang.Fishing = {
    stopped = 'Você parou de pescar',
    notInZone = 'Você não está em uma zona de pesca',
    wrongPole = 'Você não pode usar essa vara aqui',
    noLevel = 'Você não tem dados de pesca, por favor, entre de novo',
    wrongLevel = 'Você precisa ser nível %s pra pescar aqui',
    found = 'Você teve uma fisgada!'
}

Lang.Targets = {
    fishBuyer = {
        label = 'Vender seus peixes',
        icon = 'fas fa-hand-holding-dollar',
        sell = {
            label = 'Vender tudo',
            icon = 'fas fa-donate',
            description = 'Venda todos os seus peixes de uma vez!'
        },
        description = 'Vender por ' .. Lang.Info.currency .. '%s cada',
        menuTitle = 'Vender Peixes'
    },
    shopLocs = {
        icon = 'fas fa-shopping-basket',
        label = 'Explorar loja',
        input = {
            title = 'Comprar %s',
            field1title = 'Quantos comprar?',
            field2title = 'Tipo de pagamento',
            field2option1 = 'Dinheiro',
            field2option2 = 'Banco',
        },
        menuTitle = 'Loja de Pesca'
    },
    chumMaker = {
        label = 'Fazer isca',
        icon = 'fas fa-shopping-basket',
        description = 'Faça isca para usar como atrativo',
        input = {
            title = 'Confirmar fabricação de isca',
            field1title = 'Confirmar',
            description = 'Isso vai remover todos os seus peixes'
        },
        menuTitle = 'Fazer Isca'
    },
    breakDown = {
        label = 'Quebrar Materiais',
        icon = 'fas fa-dumpster-fire',
        description = 'Quebre itens em materiais',
        input = {
            description = 'Quebrar %s em materiais',
        },
        menuTitle = 'Quebrar Materiais',
        progressbar = 'Quebrando %s'
    }
}

Lang.anchor = {
    notInWater = 'O barco não está na água!',
    unanchored = 'Você soltou a âncora do seu barco',
    anchored = 'Você ancorou seu barco',
    noBoat = 'Cadê seu barco?',
}

return Lang