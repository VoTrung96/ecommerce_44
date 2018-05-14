$(function(){
  $(".upload-image").on("change", function(){
    var preview = document.querySelector('#preview');
    var files   = document.querySelector('input[type=file]').files;

    function readAndPreview(file) {

      if ( /\.(jpe?g|png|gif)$/i.test(file.name) ) {
        var reader = new FileReader();

        reader.addEventListener("load", function () {
          var image = new Image();
          image.height = 120;
          image.width = 110;
          image.title = file.name;
          image.src = this.result;
          image.className = "preview-img"
          preview.appendChild( image );
        }, false);

        reader.readAsDataURL(file);
      } else {
        alert("please chose images")
        $('.upload-image').val("")
      }

    }
    if (files.length > 4) {
      alert("please chose less than 4 file")
      $('.upload-image').val("")
    } else {
      if (files) {
        [].forEach.call(files, readAndPreview);
      }
    }
  })
})
