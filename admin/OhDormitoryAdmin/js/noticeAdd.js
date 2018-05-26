//체크옵션에 따라 세부사항
    function changeNoticeKind() {
      var select_notice = document.getElementById("select_notice");
      var select_clean = document.getElementById("select_clean");
      var select_sleep = document.getElementById("select_sleep");
      var notice_kind = document.getElementById("notice_kind");
      if (notice_kind.value == "공지사항") {
        select_notice.style.display = "block";
        select_clean.style.display = "none";
        select_sleep.style.display = "none";
        $("#notice_title").val("");
        $("#notice_title").removeAttr('readonly');
        $("#notice_title").css('border', '');
        $("#bookmark").css('background-image','url(image/notice-bookmark.svg)');
        $("#w_time, #d_time").datepicker("option", "disabled", false);

        $("#w_time, #d_time").css('border', '');
      } else if (notice_kind.value == "청소구역") {
        select_notice.style.display = "none";
        select_clean.style.display = "block";
        select_sleep.style.display = "none";
        $("#notice_title").val("청소구역");
        $("#notice_title").attr('readonly', 'readonly');
        $("#notice_title").css('border', 'none');
        $("#bookmark").css('background-image','url(image/clean-bookmark.svg)');
        $("#w_time, #d_time").datepicker("option", "disabled", true);

        //disable 스타일 변경
        $("#w_time, #d_time").css('background-color', '#FFF');
        $("#w_time, #d_time").css('border', 'none');

      } else if(notice_kind.value == "외박일지"){
        select_notice.style.display = "none";
        select_clean.style.display = "none";
        select_sleep.style.display = "block";
        $("#sleep_w_time, #sleep_d_time").datepicker();
        $("#notice_title").val("외박일지 작성");
        $("#notice_title").attr('readonly', 'readonly');
        $("#notice_title").css('border', 'none');
        $("#bookmark").css('background-image','url(image/out-bookmark.svg)');
        $("#w_time, #d_time").datepicker("option", "disabled", false);

        //disable 스타일 변경
        $("#w_time, #d_time").css('background-color', '#FFF');
        $("#w_time, #d_time").css('border', '');
      }
    }
