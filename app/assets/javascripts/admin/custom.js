$(document).ready(function(){
  $("a.input-plus-update").on('click', function(){
    var text_render = $(this).attr("onclick")
    var counter = text_render.slice(text_render.length - 2, text_render.length-1)
    var name = "product[images_attributes][" + counter + "][name]"
    var newname = "product[images_attributes][" + (parseInt(counter) + 1) + "][name]"
    text_render = text_render.replace(name, newname)
    text_render = text_render.replace(counter + ")", (parseInt(counter) + 1) + ")")
    $(this).attr("onclick", text_render)
  })

  $("a.remove").on('click', function(){
    $(this).parent().find(".destroy").val(1);
    $(this).parent().hide();
  })

  $(".del").on('click', function(){
    var ids = [];
    $('input[name=ids]:checked').each ( function(i) {
        ids[i] = $(this).attr('id');
    });
    $.ajax({
      url: "/admin/comments/delete",
      type: "POST",
      cache: false,
      data: {
        ids: ids
      },
      success: function(data){
        alert("deleted success")
        $(".card-body").html(data)
      },
      error: function (){
        alert("Something went wrong")
      }
    });
  })
})

$(document).on('click', '#checkAll', function(){
  if ($(this).prop('checked') == true){
    $('.checkbox').prop('checked', true);
  } else {
    $('.checkbox').prop('checked', false);
  }
})

$(document).on('click', "input[type='checkbox']", function(){
  var ids = [];
    $('input[name=ids]:checked').each ( function(i) {
        ids[i] = $(this).attr('id');
    });
    if (ids.length > 0) {
        $('.del').removeClass('hidden');
    } else {
        $('.del').addClass('hidden');
    }
})


function do_render(text){
  $(text).appendTo(".input-file");
}

function render_update(text, input_counter) {
  $(text).appendTo(".input-file");
}

function previewImage(input){
  if (input.files && input.files[0]) {
    var img = $(input).parent().find("img").eq(0)
    var reader = new FileReader();
    reader.onload = function(e) {
      img.attr("src", e.target.result)
    }
    reader.readAsDataURL(input.files[0]);
  }
}

function removeInput(p){
  $(p).parent().remove();
}
