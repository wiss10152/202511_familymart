<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link href="<%=request.getContextPath()%>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
	<link href="<%=request.getContextPath()%>/view/img/favicon.ico"
	rel="icon" type="img/x-icon" />
<title>ログイン画面</title>
<style>
@charset "UTF-8";


* {
    box-sizing: border-box;
}

.center {
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    padding-top: 20px;    
}


.center h1 {
    margin-bottom: 20px;
    letter-spacing: 2px;
    color: #003a8f;
}


.footer1 {
    width: 320px;
    padding: 25px 25px;

    background: transparent;
    border: 1px solid rgba(0, 0, 0, 0.2);
    border-radius: 6px;

}


.footer1 input[type="text"],
.footer1 input[type="password"] {
    width: 100%;
    height: 40px;
    padding: 0 10px;

margin-bottom:14px;
    border: 1px solid #999;
    border-radius: 4px;

    background: rgba(255, 255, 255, 0.9);
    font-size: 14px;

    outline: none;
    display: block;
    line-height: normal;
}

.footer1 input:focus {
    border-color: #008000;
}


.password-wrapper {
    position: relative;
    width: 100%;
}

.password-wrapper input {
    padding-right: 36px;
}

.eye-icon {
    position: absolute;
    right: 8px;
    top: 50%;
    transform: translateY(-50%);
    cursor: pointer;
    font-size: 18px;
    color: #333;
}

.footer1 .button {
    width: 100%;
    height: 40px;

    background: #ADADAD;
    border: 1px solid #DBDBDB;
    border-radius: 4px;

    color: #fff;
    font-size: 14px;
    font-weight: bold;
    cursor: pointer;

}

.footer1 .button:hover {
    background: #C4C4C4;
}

.footer2 {
    margin-top: 15px;
    font-size: 12px;
    color: #333;
}

</style>
<script type="text/javascript">

window.onload = function () {
    const pwd = document.getElementsByName("password")[0];
    const eye = document.getElementById("eyeIcon");

    eye.addEventListener("mouseover", function () {
        pwd.type = "text";
    });

    eye.addEventListener("mouseout", function () {
        pwd.type = "password";
    });
};
	// ここから
	history.pushState(null, null, null);
	window.addEventListener("popstate", function() {	//7月　戻るボタンの使用を禁止（注：現在ここのプログラムがあるせいでログイン後に何回かページ遷移して
	    history.pushState(null, null, null);			//ログインページまでブラウザバックすると、エラーが出されます。理由はここのプログラムのせいだと考えています。
	});
	// ここまで

	// ログイン時の処理。エラーの条件分岐など
	function login(){
		var userId	 	= document.myForm.userId.value;
		var password	= document.myForm.password.value;

		if(userId == "" || password == ""){
			alert('ユーザID または パスワード が入力されていません');
		} else if(userId.match(/[^0-9a-zA-Z]/)) {
			alert('半角英数字以外の文字が含まれています');
		} else { // 8月　上述のミスでもリクエストを送信し、二重にエラー文が表示されていたため、分岐の仕方を修正
			document.myForm.action = "<%=request.getContextPath()%>/FMlogin"
			document.myForm.submit();
			adialog();
		}
	}

	// 入力されたIDやパスワードに誤りがあった場合にアラートダイアログを表示する
	// 8月　現在、IDとパスワードどちらも誤った場合にエラーログが表示されない問題…未解決
	function adialog(){
		var disp = <%=request.getAttribute("disp_alert")%>;

		if("1".equals(disp)){
			alert('ユーザID または パスワード に誤りがあります');
		}
	}
	
	


</script>
</head>
<body>
	<div class="center">
		<h1>LOGIN</h1>
<!--		<a href="#" onclick=go_portal();><img-->
<!--			src="<%=request.getContextPath()%>/view/img/familymart.png"></a>-->

		<div class="footer1">
			<form name="myForm" method="POST" action="#">
				<input type="text" maxlength="8"
					name="userId" placeholder="User ID">
				<div class="password-wrapper">
					<input type="password" maxlength="8" name="password"
						placeholder="Password"> <span id="eyeIcon"
						class="eye-icon">👁</span>
				</div>
				<br>


					<input type="button" class="button" title="Login" value="ログイン"
						onclick="login();">

			</form>
		</div>

		<div class="footer2">FamilyMart</div>

	</div>

</body>
</html>