function myFnc(value){
  console.log("フォーカスアウトした！");
  $('#wrap').empty();
  var request = new XMLHttpRequest();
    request.open('GET', 'https://api.gnavi.co.jp/master/GAreaLargeSearchAPI/v3/?keyid=1079280779f1c4a933c7c98e388a6933', true);
    request.responseType = 'json';
 
    request.onload = function () {
      var data = this.response;
      var count = data.garea_large.length;
      var list = '<option value=' + "" +'selected> 選択してください</option>'
      $("select#wrap").append(list)
      for(var i = 0; i < count ; i++){
      if(data.garea_large[i].pref.pref_code == value){
        var areaname_l = data.garea_large[i].areaname_l
        var areacode_l = data.garea_large[i].areacode_l
        console.log("areaname_l***" + i +"***" + areaname_l);
        console.log("areacode_l***" + i +"***" + areacode_l);

        var list = '<option value= ' + areacode_l + '>' + areaname_l + '</option>'
          $("select#wrap").append(list)
      }
      }
    };
 
    request.send();

  // var url = 'https://api.gnavi.co.jp/master/GAreaMiddleSearchAPI/v3/?callback=?';
  // var params = {
  //   keyid: '1079280779f1c4a933c7c98e388a6933',
  //   format: 'json'
  // };

// $.ajax({
// type: "GET",
// url: "https://api.gnavi.co.jp/master/GAreaMiddleSearchAPI/v3",
// dataType: "json",
// jsonpCallback: "getGnaviData",
// data: {
// keyid: "1079280779f1c4a933c7c98e388a6933",
// format : json,
// callback: "getGnaviData"
// },
// success: function(data) {
// console.log("わーいわーい");
// console.log(data.rest.latitude);
// console.log(data.rest.longitude);
// }
// }); 

}