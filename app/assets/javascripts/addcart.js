$(document).ready(function(){
  $(".item_add").on("click", function(){
    var product_id = $(this).attr("product-id")
    var quantity = $("#quantity").val()
    if (typeof(quantity) == "undefined") {
      quantity = 1
    }
    var imgtodrag = $(this).parent().find("img").eq(0)
    var cart = $(".simpleCart_total");
    $.ajax({
      url: "/add",
      type: "POST",
      data: {
        product_id : product_id,
        quantity : quantity
      },
      success: function(data){
        if (data.err == 1) {
          alert("product isn't enought quantity")
        } else {
          $("#cart_quantity").html(data.quantity)
          if (imgtodrag) {
            var imgclone = imgtodrag.clone()
              .offset({
              top: imgtodrag.offset().top,
              left: imgtodrag.offset().left
            })
              .css({
                "opacity": "0.5",
                "position": "absolute",
                "height": "150px",
                "width": "150px",
                "z-index": "100"
              })
              .appendTo($("body"))
              .animate({
                "top": cart.offset().top + 10,
                "left": cart.offset().left + 30,
                "width": 75,
                "height": 75
              }, 1000, "easeInOutExpo");

            setTimeout(function () {
              cart.effect("shake", {
                times: 2
              }, 200);
            }, 1500);

            imgclone.animate({
              "width": 0,
              "height": 0
            }, function () {
              $(this).detach()
            });
          }
        }

      },
      error: function(data){
        alert("Something went wrong")
      }
    });
  })
})
