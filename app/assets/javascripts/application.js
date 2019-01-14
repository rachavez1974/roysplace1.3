  // This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require bootstrap
//= require rails-ujs
//= require turbolinks
//= require jquery.easing
//= font-awesome-rails
//= require_tree .  

//Display password if user clicks button
function showMyPassword(choice) {
  var x = document.getElementById(choice);
  if (x.type === "password") {
    x.type = "text";
  }else{
    x.type = "password";
  }
}

function showAptNumberBox(choice){
  var selectedValue = document.getElementById(choice).value;
  if(selectedValue.toLowerCase() === 'none')
    user_addresses_attributes_0_number.style.display = 'none';
  else
    user_addresses_attributes_0_number.style.display = 'block';  
}



//JS for carrousel
(function($){
  $(window).on('load', function() {
      window.loaded = true;
  });
  $(function(){
    $.fn.infiniteslide = function(options){
      //option
      var settings = $.extend({
        'speed': 100, //速さ　単位はpx/秒です。
        'direction': 'left', //up/down/left/rightから選択
        'pauseonhover': true, //マウスオーバーでストップ
        'responsive': false, //子要素の幅を%で指定しているとき
        'clone': 1
      },options);
      
      var setCss = function(obj,direction){
        $(obj).wrap('<div class="infiniteslide_wrap"></div>').parent().css({
          overflow: 'hidden'
        });

        if(direction == 'up' || direction == 'down'){
          var d = 'column';
        } else {
          var d = 'row';
        }
                
        $(obj).css({
          display: 'flex',
          flexWrap: 'nowrap',
          alignItems: 'center',
          '-ms-flex-align': 'center',
          flexDirection: d
        }).children().css({
            flex: 'none',
            display: 'block'
          });
      }
      
      var setClone = function(obj,clone){
        var $clone = $(obj).children().clone().addClass('infiniteslide_clone');
        i = 1;
        while(i <= clone){
          $clone.clone().appendTo($(obj));
          i++;
        }
      }
      
      var getWidth = function(obj){
        w = 0;
        $(obj).children(':not(.infiniteslide_clone)').each(function(key,value){
          w = w + $(this).outerWidth(true);
        });
        return w;
      }
      var getHeight = function(obj){
        h = 0;
        $(obj).children(':not(.infiniteslide_clone)').each(function(key,value){
          h = h + $(this).outerHeight(true);
        });
        return h;
      }

      
      var getSpeed = function(l,s){
        return l / s;
      }
      var getNum = function(obj,direction){
        if(direction == 'up' || direction == 'down'){
          var num = getHeight(obj);
        } else {
          var num = getWidth(obj);
        }
        return num;
      }
      
      var getTranslate = function(num,direction){
        if(direction == 'up' || direction == 'down'){
          var i = '0,-' + num + 'px,0';
        } else {
          var i = '-' + num + 'px,0,0';
        }
        return i;
      }
      
      var setAnim = function(obj,id,direction,speed){
        var num = getNum(obj,direction);
        if(direction == 'up' || direction == 'down'){
          $(obj).parent('.infiniteslide_wrap').css({
            height: num + 'px'
          });
        }
        var i = getTranslate(num,direction);
        
        $(obj).attr('data-style','infiniteslide' + id);

        var css = '@keyframes infiniteslide' + id + '{' + 
                'from {transform:translate3d(0,0,0);}' + 
                'to {transform:translate3d(' + i + ');}' + 
              '}';
        $('<style />').attr('id','infiniteslide' + id + '_style')
        .html(css)
        .appendTo('head');
        
        if(direction == 'right' || direction == 'down'){
          var reverse = ' reverse';
        } else {
          var reverse = '';
        }
        
        $(obj).css({
          animation: 'infiniteslide' + id + ' ' + getSpeed(num,speed) + 's linear 0s infinite' + reverse
        });
      }
      var setStop = function(obj){
        $(obj).on('mouseenter',function(){
          $(this).css({
            animationPlayState: 'paused'
          });
        }).on('mouseleave',function(){
          $(this).css({
            animationPlayState: 'running'
          });
        });
      }
      
      var setResponsive = function(obj,direction){
          var num = getNum(obj,direction);
          var i = getTranslate(num,direction);
          return i;
        };
      
      
      
    
      return this.each(function(key,value){
        var $this = $(this);
        var num = Date.now() + Math.floor(10000*Math.random()).toString(16);
        if(settings.pauseonhover == true){
          setStop($this);
        }
        var _onload = function(){
          setCss($this,settings.direction);
          setClone($this,settings.clone);
          setAnim($this,num,settings.direction,settings.speed);
          
          if(settings.responsive){
            $(window).on('resize',function(){
              var i = setResponsive($this,settings.direction);
              var styleid = $this.attr('data-style');
              var stylehtml = $('#' + styleid + '_style').html();
              
              var stylehtml_new = stylehtml.replace(/to {transform:translate3d\((.*?)\)/,'to {transform:translate3d(' + i + ')');
              $('#' + styleid + '_style').html(stylehtml_new);

            });
          }
        };

        if (window.loaded) {
          _onload();
        } else {
          $(window).on('load', _onload);
        }
      });
      
    }
  });
})(jQuery);

//JS carrousel ends here







(function ($) {
    "use strict";

    /*[ Load page ]
    ===========================================================*/
    $(".animsition").animsition({
        inClass: 'fade-in',
        outClass: 'fade-out',
        inDuration: 1500,
        outDuration: 800,
        linkElement: '.animsition-link',
        loading: true,
        loadingParentElement: 'html',
        loadingClass: 'animsition-loading-1',
        loadingInner: '<div class="cp-spinner cp-meter"></div>',
        timeout: false,
        timeoutCountdown: 5000,
        onLoadEvent: true,
        browser: [ 'animation-duration', '-webkit-animation-duration'],
        overlay : false,
        overlayClass : 'animsition-overlay-slide',
        overlayParentElement : 'html',
        transition: function(url){ window.location.href = url; }
    });
    
    /*[ Back to top ]
    ===========================================================*/
    var windowH = $(window).height()/2;

    $(window).on('scroll',function(){
        if ($(this).scrollTop() > windowH) {
            $("#myBtn").css('display','flex');
        } else {
            $("#myBtn").css('display','none');
        }
    });

    $('#myBtn').on("click", function(){
        $('html, body').animate({scrollTop: 0}, 300);
    });


    /*[ Select ]
    ===========================================================*/
    $(".selection-1").select2({
        minimumResultsForSearch: 20,
        dropdownParent: $('#dropDownSelect1')
    });

    /*[ Daterangepicker ]
    ===========================================================*/
    $('.my-calendar').daterangepicker({
        "singleDatePicker": true,
        "showDropdowns": true,
        locale: {
            format: 'DD/MM/YYYY'
        },
    });

    var myCalendar = $('.my-calendar');
    var isClick = 0;

    $(window).on('click',function(){ 
        isClick = 0;
    });

    $(myCalendar).on('apply.daterangepicker',function(){ 
        isClick = 0;
    });

    $('.btn-calendar').on('click',function(e){ 
        e.stopPropagation();

        if(isClick == 1) isClick = 0;   
        else if(isClick == 0) isClick = 1;

        if (isClick == 1) {
            myCalendar.focus();
        }
    });

    $(myCalendar).on('click',function(e){ 
        e.stopPropagation();
        isClick = 1;
    });

    $('.daterangepicker').on('click',function(e){ 
        e.stopPropagation();
    });


    /*[ Play video 01]
    ===========================================================*/
    var srcOld = $('.video-mo-01').children('iframe').attr('src');

    $('[data-target="#modal-video-01"]').on('click',function(){
        $('.video-mo-01').children('iframe')[0].src += "&autoplay=1";

        setTimeout(function(){
            $('.video-mo-01').css('opacity','1');
        },300);      
    });

    $('[data-dismiss="modal"]').on('click',function(){
        $('.video-mo-01').children('iframe')[0].src = srcOld;
        $('.video-mo-01').css('opacity','0');
    });
    

    /*[ Fixed Header ]
    ===========================================================*/
    var header = $('header');
    var logo = $(header).find('.logo img');
    var linkLogo1 = $(logo).attr('src');
    var linkLogo2 = $(logo).data('logofixed');


    $(window).on('scroll',function(){
        if($(this).scrollTop() > 5 && $(this).width() > 992) {
            $(logo).attr('src',linkLogo2);
            $(header).addClass('header-fixed');
        }
        else {
            $(header).removeClass('header-fixed');
            $(logo).attr('src',linkLogo1);
        }
        
    });

    /*[ Show/hide sidebar ]
    ===========================================================*/
    $('body').append('<div class="overlay-sidebar trans-0-4"></div>');
    var ovlSideBar = $('.overlay-sidebar');
    var btnShowSidebar = $('.btn-show-sidebar');
    var btnHideSidebar = $('.btn-hide-sidebar');
    var sidebar = $('.sidebar');

    $(btnShowSidebar).on('click', function(){
        $(sidebar).addClass('show-sidebar');
        $(ovlSideBar).addClass('show-overlay-sidebar');
    })

    $(btnHideSidebar).on('click', function(){
        $(sidebar).removeClass('show-sidebar');
        $(ovlSideBar).removeClass('show-overlay-sidebar');
    })

    $(ovlSideBar).on('click', function(){
        $(sidebar).removeClass('show-sidebar');
        $(ovlSideBar).removeClass('show-overlay-sidebar');
    })


    /*[ Isotope ]
    ===========================================================*/
    var $topeContainer = $('.isotope-grid');
    var $filter = $('.filter-tope-group');

    // filter items on button click
    $filter.each(function () {
        $filter.on('click', 'button', function () {
            var filterValue = $(this).attr('data-filter');
            $topeContainer.isotope({filter: filterValue});
        });
        
    });

    // init Isotope
    $(window).on('load', function () {
        var $grid = $topeContainer.each(function () {
            $(this).isotope({
                itemSelector: '.isotope-item',
                percentPosition: true,
                animationEngine : 'best-available',
                masonry: {
                    columnWidth: '.isotope-item'
                }
            });
        });
    });

    var labelGallerys = $('.label-gallery');

    $(labelGallerys).each(function(){
        $(this).on('click', function(){
            for(var i=0; i<labelGallerys.length; i++) {
                $(labelGallerys[i]).removeClass('is-actived');
            }

            $(this).addClass('is-actived');
        });
    });

    

})(jQuery);

//



