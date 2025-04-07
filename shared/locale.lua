Locale = {
    ['en'] = {
        --Client strings
        --Debug
        updateContextDebug          =
        'Updating context for player %d, with house %s, clientside. This was triggered by this client.',
        updateOptionsDebug          =
        'Updating house and house seller options for player %d, with house %s, clientside. This was triggered by this client.',
        houseUpdatingSuccessDebug   =
        'Successfully updated house and house seller options for player %d with house %s, clientside. This was triggered by this client.',
        createSellerPedIntDebug     = 'Creating seller ped interaction.',
        createSellerPedIntSuccess   = 'Seller interaction created successfully.',
        removeSellerPedIntDebug     = 'Removing seller ped interaction.',
        removeSellerPedIntSuccess   = 'Seller interaction removed successfully.',
        removeSellerPedIntFail      = 'Seller interaction removal failed.',
        createSellerPedDebug        = 'Creating seller ped.',
        createSellerPedSuccess      = 'Seller ped created successfully.',
        createSellerPedFail         = 'Seller ped creation failed.',
        removeSellerPedDebug        = 'Removing seller ped.',
        removeSellerPedSuccess      = 'Seller ped removed successfully.',
        removeSellerPedFail         = 'Seller ped removal failed.',
        updatePhysHouseDebug        = 'Updating physical house for player %d. This was triggered by this client.',
        skipUpdatePhysHouseDebug    =
        'Player %d does not have a selected social house. Skipping UpdatePhysicalHouse for them. This was triggered by this client.',
        updatePhysHouseSuccess      = 'Updated physical house for player %d. This was triggered by this client.',
        --Context menus
        houseSelectionContextTitle  = 'House selection menu',
        houseSellerContextTitle     = 'House seller menu',
        hscChooseTitle              = 'Choose a social house',
        hscChooseDesc               = 'Choose your social house amongst a list of available houses.',
        hscKeyTitle                 = 'Buy a key',
        hscKeyDesc                  = 'Buy a key for your selected social house.',
        priceLabel                  = 'Price',
        paymentMethodLabel          = 'Payment method',
        --Notifications
        notificationTitle           = 'Social Housing',
        houseChoosingSuccess        = 'You\'ve chosen %s as your social house.',
        houseChoosingError          = 'Could not choose house correctly. Contact server administration.',
        keyPurchaseSuccess          = 'House key bought successfully.',
        leftHouse                   = 'You\'ve left your house.',
        enteredHouse                = 'You\'ve entered your house.',
        dontHaveKey                 = 'You don\'t have a key for this house.',
        --Targets
        speakWithSellerTarget       = 'Speak with the seller',
        openWardrobeTarget          = 'Open the wardrobe',
        openStashTarget             = 'Open the stash',
        exitHouseTarget             = 'Exit the house',
        enterHouseTarget            = 'Enter the house',
        --TextUI
        openWardrobe                = 'Press [E] to open the wardrobe',
        openStash                   = 'Press [E] to open the stash',
        exitHouse                   = 'Press [E] to exit the house',
        enterHouse                  = 'Press [E] to enter the house',
        --Progress bars
        progBarSpeakWithSeller      = 'Speaking with the seller...',
        progBarStopSWS              = 'You stopped speaking with the seller.',

        --Server strings
        --Debug
        startingResourceDebug       = 'Starting %s.',
        startingResourceSuccess     = 'Started %s successfully.',
        runningChecksDebug          = 'Running checks.',
        playerConnectedPedDebug     =
        'Player with server ID %d has just connected. Ped model was not checked so far. Checking ped model.',
        playerConnectedDebug        = 'Player with server ID %d has just connected.',
        playerNoHouseDBDebug        = 'Player %d has no house registered in the DB.',
        fetchingUpdatingCLDebug     =
        'Fetching house and updating clientside selected house for player %d with house %s, serverside.',
        nonExisting                 = 'non-existing',
        fetchingUpdatingCLFail      =
        'Failed to fetch house and update clientside selected house for player %d with house %s, serverside. setHouse Callback success is nil.',
        fetchingUpdatingCLSuccess   =
        'Successfully fetched house and updated clientside selected house for player %d with house %s, serverside.',
        stashTable                  = 'Stash table: ',
        registeringStashesDebug     = 'Registering ipl stashes.',
        registeringStashesSuccess   = 'Registered %d stashes.',
        registeringStashDebug       = 'Registering stash for ipl %s.',
        registeringStashSuccess     = 'Successfully registered stash for ipl %s.',
        registeredStashesDebug      = 'Stashes registered: ',
        pedObjectNotFound           = 'Ped object not found. Check the config.lua file.',
        pedObjectFound              = 'Ped object found. Model: ',
        invalidPedData              =
        'Invalid data for \"Config.SellerPed", make sure its model string is correct and that every parameter exists. Check the config.lua file.',
        pedObjectValidSuccess       = 'Ped object validated successfully.',
        configCheckDebug            = 'Checking configuration.',
        housesNotFound              = 'No houses were found. Check the config.lua file.',
        housesFound                 = 'Found %d houses.',
        invalidHouseKey             =
        'Invalid key for house %s, make sure it is shorter than 257 and longer than 0 characters. Check the config.lua file.',
        validHouseKey               = 'House key %s validated correctly.',
        invalidHouseData            =
        'Invalid data for house %s, make sure that every parameter exists, follow the template if in doubt. Check the config.lua file.',
        validHouseData              = 'House data for %s validated correctly.',
        foundIplsDebug              = 'Found %d ipls.',
        noIplsFound                 = 'No ipls were found. Check the config.lua file.',
        invalidIplKey               =
        'Invalid key for ipl %d, make sure it is shorter than 257 and longer than 0 characters. Check the config.lua file.',
        validIplKey                 = 'Ipl key %s validated correctly.',
        invalidIplData              =
        'Invalid data for ipl %s, make sure that every parameter exists, follow the template if in doubt. Check the config.lua file.',
        validIplData                = 'Ipl data for %s validated correctly.',
        invalidInteractionMethod    = 'Incorrect configuration for \"Config.InteractionMethod". Check the config.lua file.',
        validInteractionMethod      = 'Interaction method %s validated correctly.',
        invalidAppearance           = 'Incorrect configuration for \"Config.Appearance". Check the config.lua file.',
        validAppearance             = 'Appearance resource %s validated correctly.',
        skipModelCheck              = 'No players found. Skipping ped model check.',
        doneCheckingConfig          = 'Done checking configuration. ',
        checkingPlayersHouses       = 'Checking players\' houses.',
        skipHouseSetting            = 'No players found. Skipping house setting.',
        houseSettingForPlayersDebug = 'Found %d players. Starting house setting for their clients.',
        doneCheckingPlayersHouses   = 'Done checking players\' houses. ',
        cheatSetHouse               = 'Player with server ID %d tried to set database house data from too far away. Possible cheater.',
        cheatBuyKey                 = 'Player with server ID %d tried to buy a key from too far away. Possible cheater.',
        --Notifications
        cantLoadMoney               = 'Issue loading your monetary accounts. Contact server staff.',
        couldntBuyKey               = 'Could not buy key. Reason: ',
        invalidItem                 = 'item is invalid. Contact server staff.',
        invalidInventory            = 'inventory target is invalid. Contact server staff.',
        inventoryFull               = 'inventory is full.',
        inventoryWeightLimit        = 'it\'s too heavy for you.',
        notEnoughMoney              = 'not enough money.',
        --Stashes
        stashLabel                  = 'Social house stash',
    },
    ['it'] = {
        --Stringhe client
        --Debug
        updateContextDebug          =
        'Aggiornamento del menù per il giocatore %d, con casa %s, lato client. Questo è stato triggerato da questo client.',
        updateOptionsDebug          =
        'Aggiornamento delle opzioni della casa e del venditore per il giocatore %d, con casa %s, lato client. Questo è stato triggerato da questo client.',
        houseUpdatingSuccessDebug   =
        'Casa e opzioni del venditore aggiornate con successo per il giocatore %d con casa %s, lato client. Questo è stato triggerato da questo client.',
        createSellerPedIntDebug     = 'Creazione dell\'interazione con il venditore.',
        createSellerPedIntSuccess   = 'Interazione con il venditore creata con successo.',
        removeSellerPedIntDebug     = 'Rimozione dell\'interazione con il venditore.',
        removeSellerPedIntSuccess   = 'Interazione con il venditore rimossa con successo.',
        removeSellerPedIntFail      = 'Rimozione dell\'interazione con il venditore fallita.',
        createSellerPedDebug        = 'Creazione del venditore.',
        createSellerPedSuccess      = 'Venditore creato con successo.',
        createSellerPedFail         = 'Creazione del venditore fallita.',
        removeSellerPedDebug        = 'Rimozione del venditore.',
        removeSellerPedSuccess      = 'Venditore rimosso con successo.',
        removeSellerPedFail         = 'Rimozione del venditore fallita.',
        updatePhysHouseDebug        =
        'Aggiornamento della casa fisica per il giocatore %d. Questo è stato triggerato da questo client.',
        skipUpdatePhysHouseDebug    =
        'Il giocatore %d non ha una casa popolare selezionata. Salto l\'aggiornamento della casa fisica di tale giocatore. Questo è stato triggerato da questo client.',
        updatePhysHouseSuccess      =
        'Casa fisica aggiornata per il giocatore %d. Questo è stato triggerato da questo client.',
        --Menu
        houseSelectionContextTitle  = 'Menù di selezione della casa',
        houseSellerContextTitle     = 'Menù del venditore di case',
        hscChooseTitle              = 'Scegli una casa popolare',
        hscChooseDesc               = 'Scegli la tua casa popolare tra una lista di case disponibili.',
        hscKeyTitle                 = 'Compra una chiave',
        hscKeyDesc                  = 'Compra una chiave per la tua casa popolare.',
        priceLabel                  = 'Prezzo',
        paymentMethodLabel          = 'Metodo di pagamento',
        --Notifiche
        notificationTitle           = 'Case popolari',
        houseChoosingSuccess        = 'Hai scelto %s come tua casa popolare.',
        houseChoosingError          = 'Impossibile scegliere la casa correttamente. Contatta l\'amministrazione del server.',
        keyPurchaseSuccess          = 'Chiave della casa acquistata con successo.',
        leftHouse                   = 'Hai lasciato la tua casa.',
        enteredHouse                = 'Sei entrato nella tua casa.',
        dontHaveKey                 = 'Non hai una chiave per questa casa.',
        --Targets
        speakWithSellerTarget       = 'Parla con il venditore',
        openWardrobeTarget          = 'Apri l\'armadio',
        openStashTarget             = 'Apri il deposito',
        exitHouseTarget             = 'Esci dalla casa',
        enterHouseTarget            = 'Entra nella casa',
        --TextUI
        openWardrobe                = 'Premi [E] per aprire l\'armadio',
        openStash                   = 'Premi [E] per aprire il deposito',
        exitHouse                   = 'Premi [E] per uscire dalla casa',
        enterHouse                  = 'Premi [E] per entrare nella casa',
        --Progress bars
        progBarSpeakWithSeller      = 'Parlando con il venditore...',
        progBarStopSWS              = 'Hai smesso di parlare con il venditore.',

        --Stringhe server
        --Debug
        startingResourceDebug       = 'Avvio di %s.',
        startingResourceSuccess     = '%s avviato con successo.',
        runningChecksDebug          = 'Esecuzione dei controlli.',
        playerConnectedPedDebug     =
        'Il giocatore con ID server %d si è appena connesso. Il modello del ped non è stato ancora controllato. Controllo del modello del ped.',
        playerConnectedDebug        = 'Il giocatore con ID server %d si è appena connesso.',
        playerNoHouseDBDebug        = 'Il giocatore %d non ha una casa registrata nel database.',
        fetchingUpdatingCLDebug     =
        'Ottenimento della casa e aggiornamento della casa selezionata lato client per il giocatore %d con casa %s, lato server.',
        nonExisting                 = 'inesistente',
        fetchingUpdatingCLFail      =
        'Impossibile ottenere la casa e aggiornare la casa selezionata lato client per il giocatore %d con casa %s, lato server. Il callback setHouse ha ritornato nil.',
        fetchingUpdatingCLSuccess   =
        'Casa ottenuta e aggiornata con successo lato client per il giocatore %d con casa %s, lato server.',
        stashTable                  = 'Tabella del deposito: ',
        registeringStashesDebug     = 'Registrazione dei depositi IPL.',
        registeringStashesSuccess   = 'Registrati %d depositi.',
        registeringStashDebug       = 'Registrazione del deposito per IPL %s.',
        registeringStashSuccess     = 'Deposito registrato con successo per IPL %s.',
        registeredStashesDebug      = 'Depositi registrati: ',
        pedObjectNotFound           = 'Oggetto ped non trovato. Controlla il file config.lua.',
        pedObjectFound              = 'Oggetto ped trovato. Modello: ',
        invalidPedData              =
        'Dati non validi per \"Config.SellerPed\", assicurati che la stringa del modello sia corretta e che ogni parametro esista. Controlla il file config.lua.',
        pedObjectValidSuccess       = 'Oggetto ped validato con successo.',
        configCheckDebug            = 'Controllo della configurazione.',
        housesNotFound              = 'Nessuna casa trovata. Controlla il file config.lua.',
        housesFound                 = 'Trovate %d case.',
        invalidHouseKey             =
        'Chiave non valida per la casa %s, assicurati che sia più corta di 257 caratteri e più lunga di 0. Controlla il file config.lua.',
        validHouseKey               = 'Chiave della casa %s validata correttamente.',
        invalidHouseData            =
        'Dati non validi per la casa %s, assicurati che ogni parametro esista, segui il template in caso di dubbi. Controlla il file config.lua.',
        validHouseData              = 'Dati della casa per %s validati correttamente.',
        foundIplsDebug              = 'Trovati %d IPL.',
        noIplsFound                 = 'Nessun IPL trovato. Controlla il file config.lua.',
        invalidIplKey               =
        'Chiave non valida per IPL %d, assicurati che sia più corta di 257 caratteri e più lunga di 0. Controlla il file config.lua.',
        validIplKey                 = 'Chiave IPL %s validata correttamente.',
        invalidIplData              =
        'Dati non validi per IPL %s, assicurati che ogni parametro esista, segui il template in caso di dubbi. Controlla il file config.lua.',
        validIplData                = 'Dati IPL per %s validati correttamente.',
        invalidInteractionMethod    =
        'Configurazione non corretta per \"Config.InteractionMethod\". Controlla il file config.lua.',
        validInteractionMethod      = 'Metodo di interazione %s validato correttamente.',
        invalidAppearance           = 'Configurazione non corretta per \"Config.Appearance\". Controlla il file config.lua.',
        validAppearance             = 'Risorsa di aspetto %s validata correttamente.',
        skipModelCheck              = 'Nessun giocatore trovato. Salto il controllo del modello del ped.',
        doneCheckingConfig          = 'Controllo della configurazione completato. ',
        checkingPlayersHouses       = 'Controllo delle case dei giocatori.',
        skipHouseSetting            = 'Nessun giocatore trovato. Salto l\'impostazione della casa.',
        houseSettingForPlayersDebug = 'Trovati %d giocatori. Avvio dell\'impostazione della casa per i loro client.',
        doneCheckingPlayersHouses   = 'Controllo delle case dei giocatori completato. ',
        cheatSetHouse               =
        'Giocatore con server ID %d ha provato a settare la sua casa popolare nel database da troppo lontano. Possibile cheater.',
        cheatBuyKey                 = 'Giocatore con server ID %d ha provato a comprare una chiave da troppo lontano. Possibile cheater.',
        --Notifiche
        cantLoadMoney               = 'Problema nel caricamento dei tuoi conti monetari. Contatta lo staff del server.',
        couldntBuyKey               = 'Impossibile acquistare la chiave. Motivo: ',
        invalidItem                 = 'l\'oggetto non è valido. Contatta lo staff del server.',
        invalidInventory            = 'l\'inventario di destinazione non è valido. Contatta lo staff del server.',
        inventoryFull               = 'l\'inventario è pieno.',
        inventoryWeightLimit        = 'è troppo pesante per te.',
        notEnoughMoney              = 'non hai abbastanza soldi.',
        --Depositi
        stashLabel                  = 'Deposito della casa popolare',
    }
}
