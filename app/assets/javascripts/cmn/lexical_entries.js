var ctrl = Paloma.controller("Cmn/LexicalEntries");

ctrl.prototype.index = function() {
    ResourcesTable.setup({
        baseUrl: lexicalEntriesPath()
    });
};

ctrl.prototype.quick_new = function() {
};

ctrl.prototype.selection = function() {
    ResourcesTable.setup({
        baseUrl: lexicalEntriesPath()
    });
};

function lexicalEntriesPath() {
    var lexicalEntriesRegexp = /.*\/[a-z]{3}\/lexicons\/\d+\/lexical_entries/;
    var currentUrl = $(location).prop('href')
    var match = lexicalEntriesRegexp.exec(currentUrl);
    return match[0];
}
