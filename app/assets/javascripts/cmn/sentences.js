var ctrl = Paloma.controller("Cmn/Sentences");

ctrl.prototype.index = function() {
    ResourcesTable.setup({
        baseUrl: sentencesPath()
    });
};

ctrl.prototype.quick_new = function() {
};

ctrl.prototype.selection = function() {
    ResourcesTable.setup({
        baseUrl: sentencesPath()
    });
};

function sentencesPath() {
    var sentencesRegexp = /.*\/[a-z]{3}\/lexicons\/\d+\/sentences/;
    var currentUrl = $(location).prop('href')
    var match = sentencesRegexp.exec(currentUrl);
    return match[0];
}
