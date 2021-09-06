// Subscriptions

function getAllSubscriptions(){
    var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

    db.transaction(
        function(tx) {
            // Create the database if it doesn't already exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS Subscriptions(id INT, name TEXT, amount TEXT, currency TEXT)');

            // Get all accounts
            var rs = tx.executeSql('SELECT * FROM Subscriptions');

            for (var i = 0; i < rs.rows.length; i++) {
                var account = rs.rows.item(i)
                listModel.append({accountID: parseInt(account.id), name: account.name, amount: parseFloat(account.amount), currency: account.currency, checked: true})
            }

            // update total value
            Utils.setTotalValueSubs()
        }
     )
}

function saveSubscription(name, amount, currency){
    var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

    db.transaction(
        function(tx) {
            tx.executeSql('INSERT INTO Subscriptions VALUES(?, ?, ?, ?)', [ Date.now(), name, amount, currency ]);
        }
    )
}

function deleteSubscription(id){
    var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

    db.transaction(
        function(tx) {
            tx.executeSql('DELETE FROM Subscriptions WHERE id=?', [ id ]);
        }
    )
}

function editSubscription(){
    var index = rectangleEdit.textEditIndex.text
    var id = rectangleEdit.textEditID.text
    var newName = rectangleEdit.textEditName.text
    var newCost = rectangleEdit.spinboxEditAmount.value/100
    var newCurrency = rectangleEdit.comboBoxEditCurrency.displayText

    // update ListModel
    listModel.set(index, { name: newName, amount: parseFloat(newCost), currency: newCurrency})

    // update database
    var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

    db.transaction(
        function(tx) {
            tx.executeSql('UPDATE Subscriptions SET name=?, amount=?, currency=? WHERE id=?', [ newName, newCost, newCurrency, id ]);
        }
    )
}


// Accounts

function getAllAccounts(){
    var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

    db.transaction(
        function(tx) {
            // Create the database if it doesn't already exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS Accounts(id INT, name TEXT, amount TEXT, currency TEXT)');

            // Get all accounts
            var rs = tx.executeSql('SELECT * FROM Accounts');

            for (var i = 0; i < rs.rows.length; i++) {
                var account = rs.rows.item(i)
                listModel.append({accountID: parseInt(account.id), name: account.name, amount: parseFloat(account.amount), currency: account.currency})
            }

            // update total value
            Utils.setTotalValue()
        }
     )
}

function saveAccount(name, amount, currency){
    var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

    db.transaction(
        function(tx) {
            tx.executeSql('INSERT INTO Accounts VALUES(?, ?, ?, ?)', [ Date.now(), name, amount, currency ]);
        }
    )
}

function deleteAccount(id){
    var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

    db.transaction(
        function(tx) {
            tx.executeSql('DELETE FROM Accounts WHERE id=?', [ id ]);
        }
    )
}

function editAccount(){
    var index = rectangleEdit.textEditIndex.text
    var id = rectangleEdit.textEditID.text
    var newName = rectangleEdit.textEditName.text
    var newAmount = rectangleEdit.spinboxEditAmount.value/100
    var newCurrency = rectangleEdit.comboBoxEditCurrency.displayText

    // update ListModel
    listModel.set(index, { name: newName, amount: parseFloat(newAmount), currency: newCurrency})

    // update database
    var db = LocalStorage.openDatabaseSync("AccountsDB", "1.0", "Data about accounts", 1000000)

    db.transaction(
        function(tx) {
            tx.executeSql('UPDATE Accounts SET name=?, amount=?, currency=? WHERE id=?', [ newName, newAmount, newCurrency, id ]);
        }
    )

    // refresh total sum
    Utils.setTotalValue()
}
