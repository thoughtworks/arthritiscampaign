$(function() {
  function handleFileSelect(file) {
    if (!(window.File && window.FileReader && window.FileList && window.Blob)) {
      // File APIs are not supported
      return;
    }
    reader = new FileReader();

    reader.onload = function (e) {
        var picture = new Image();
        picture.src = e.target.result;
        picture.className = 'picture';
        $('#picture').html(picture);

        picture.onload = function () {
          $('.controls label.active input')[0].click();
        };
    };

    reader.readAsDataURL(file);
  };

  function updateBanner(bannerName) {
    var image = $('#picture img');
    $.ajax({
      type: 'GET',
      url: '/max_width', 
      dataType: 'json',
      data: { width: image.width(), height: image.height(), banner_name: bannerName }, 
      success: function (response) {
        $('#editor-canvas').width(image.width());    
        overlayBannerOnTheImage(response, bannerName);
      }
    });
  };

  function overlayBannerOnTheImage(sizingInfo, bannerName) {
    bannerImg = '<img class="banner-image '+bannerName+'" src="/images/banners/'+bannerName+'.png" width="'+sizingInfo.width+'">';

    $('#banner').html(bannerImg);
    $('#banner').attr('class', sizingInfo.gravity);

    if (sizingInfo.gravity === 'south') {
      $('#banner').css('margin-left', -1 * (sizingInfo.width / 2));
    }
  };

  $('.controls label input[type="radio"]').click(function () {
    var bannerName = $(this).val();

    $('.controls label').removeClass('active');
    $(this).parent('label').addClass('active');

    // this is the cherry on the top
    $('body').removeAttr('class');
    $('body').addClass(bannerName);

    updateBanner(bannerName);
  });
  $('input#choose-picture').on("change", function (evt) {
    //$('#editor-canvas').css('width', '100%');
    var filePath = null;
    var noImage = false;
    if(evt.target.files == undefined){//IE
      filePath = evt.target.value;
      noImage = filePath.match(".*.([gG][iI][fF]|[jJ][pP][gG]|[jJ][pP][eE][gG]|[bB][mM][pP])$") == null;
    }
    else{
      filePath = evt.target.files[0];
      noImage = evt.target.files[0].type.match('image.*') == null;
    }
    if (noImage) {
      alert("Please, choose an image.");
      $('#generate-btn').attr("disabled", "disabled");
      $('#picture').html("");
      $('#banner').html("");
      $("div.color-picker").hide();
      $("div.generate").hide();
      return;
    }
    handleFileSelect(filePath);
    $('#generate-btn').removeAttr("disabled");
    $("div.color-picker").show();
    $("div.generate").show();
  });
});
