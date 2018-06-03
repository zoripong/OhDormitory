//체크옵션에 따라 세부사항
    function changeNoticeKind() {
      var select_notice = document.getElementById("select_notice");
      var select_clean = document.getElementById("select_clean");
      var select_sleep = document.getElementById("select_sleep");
      var notice_kind = document.getElementById("notice_kind");
      if (notice_kind.value == 0) {
        select_notice.style.display = "block";
        select_clean.style.display = "none";
        select_sleep.style.display = "none";
        $("#notice_title").val("");
        $("#notice_title").removeAttr('readonly');
        $("#notice_title").css('border', '');
        $("#bookmark").css('background-image','url(image/notice-bookmark.svg)');
        
        $("#w_time, #d_time").css('border', '');
      } else if (notice_kind.value == 1) {
        select_notice.style.display = "none";
        select_clean.style.display = "block";
        select_sleep.style.display = "none";
        $("#notice_title").val("청소구역");
        $("#notice_title").attr('readonly', 'readonly');
        $("#notice_title").css('border', 'none');
        $("#bookmark").css('background-image','url(image/clean-bookmark.svg)');
       

        //disable 스타일 변경
        $("#w_time, #d_time").css('background-color', '#FFF');
        $("#w_time, #d_time").css('border', 'none');

      } else if(notice_kind.value == 2){
        select_notice.style.display = "none";
        select_clean.style.display = "none";
        select_sleep.style.display = "block";
        
        $("#notice_title").val("외박일지 작성");
        $("#notice_title").attr('readonly', 'readonly');
        $("#notice_title").css('border', 'none');
        $("#bookmark").css('background-image','url(image/out-bookmark.svg)');
        

        //disable 스타일 변경
        $("#w_time, #d_time").css('background-color', '#FFF');
        $("#w_time, #d_time").css('border', '');
      }
    }
