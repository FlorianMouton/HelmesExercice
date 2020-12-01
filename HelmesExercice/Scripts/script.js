function GetSectors() {  
    $.ajax({
        type: "GET",
        url: '/Home/getSectors',
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            var datas = jQuery.parseJSON(result);
            var sectors = $("[id=sectors]");
            var tab = "";
            for (var i = 0; i < datas.length; i++)
            {
                tab = "";
                for (var j = 0; j < datas[i]["LevelId"]-1; j++) {
                    tab += "\xA0\xA0\xA0\xA0";
                }
                var opt = document.createElement("option");
                opt.value = datas[i]["SectorID"];
                opt.text = tab + datas[i]["Label"];
                sectors.append(opt);
            }
            document.getElementById("name").value = localStorage.getItem('name');
            document.getElementById("terms").checked = localStorage.getItem('terms');
            $("#sectors").val(localStorage.getItem("sectors").split(','));

        }
    });
}

function Save(){
    var name = localStorage.getItem('name');
    var sectors = localStorage.getItem('sectors');
    var terms = localStorage.getItem('terms');
    if (name == '' || sectors == '' || terms == 'false') {
        alert("All fields are mandatory");
    }
    else {
        $.ajax({
            type: "POST",
            url: '/Home/SaveChanges',
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            data: JSON.stringify({ Name: name, Sectors: sectors, Terms: terms }),
            success: function (result) {
            }
        });
    }
}

function valueChanged() {
    localStorage.setItem('name', $("[id=name]").val());
    localStorage.setItem('sectors', $("[id=sectors]").val());
    localStorage.setItem('terms', document.getElementById("terms").checked);
}