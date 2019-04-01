function onload(){
    console.log("都道府県！");
  $('#pref').empty();
  var request = new XMLHttpRequest();
    request.open('GET', 'https://api.gnavi.co.jp/master/PrefSearchAPI/v3/?keyid=1079280779f1c4a933c7c98e388a6933', true);
    request.responseType = 'json';
 
    request.onload = function () {
      var data = this.response;
      var prefLength = data.pref.length;
      var prefList = '<option value=' + "" +'selected> 選択してください</option>'
      $("select#pref").append(prefList)
      for(var i = 0; i < prefLength ; i++){
        var pref_name = data.pref[i].pref_name;
        var pref_code =data.pref[i].pref_code;

        var prefList = '<option value= ' + pref_code + '>' + pref_name + '</option>'
          $("select#pref").append(prefList);
      }
    };
 
     request.send();
};

function outFcs(value){
  console.log("フォーカスアウトした！");
  $('#areal').empty();
  var request = new XMLHttpRequest();
    request.open('GET', 'https://api.gnavi.co.jp/master/GAreaLargeSearchAPI/v3/?keyid=1079280779f1c4a933c7c98e388a6933', true);
    request.responseType = 'json';
 
    request.onload = function () {
      var data = this.response;
      var count = data.garea_large.length;
      var list = '<option value=' + "" +'selected> 選択してください</option>'
      $("select#areal").append(list)
      for(var i = 0; i < count ; i++){
      if(data.garea_large[i].pref.pref_code == value){
        var areaname_l = data.garea_large[i].areaname_l
        var areacode_l = data.garea_large[i].areacode_l
        console.log("areaname_l***" + i +"***" + areaname_l);
        console.log("areacode_l***" + i +"***" + areacode_l);

        var list = '<option value= ' + areacode_l + '>' + areaname_l + '</option>'
          $("select#areal").append(list)
      }
      }
    };
 
     request.send();

}