<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<link href="<%= request.getContextPath() %>/view/css/W0051.css"
	rel="stylesheet" type="text/css" />
<title>FamilyMartログイン画面</title>
<script type="text/javascript">

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
			document.myForm.action = "<%= request.getContextPath() %>/FMlogin"
			document.myForm.submit();
			adialog();
		}
	}

	// 入力されたIDやパスワードに誤りがあった場合にアラートダイアログを表示する
	// 8月　現在、IDとパスワードどちらも誤った場合にエラーログが表示されない問題…未解決
	function adialog(){
		var disp = <%= request.getAttribute("disp_alert") %>;

		if("1".equals(disp)){
			alert('ユーザID または パスワード に誤りがあります');
		}
	}

</script>
</head>
<body>
<div class="center">
	<h1>Login</h1>
	<a href="#" onclick=go_portal();><img src="<%= request.getContextPath() %>/view/img/familymart.png"></a>

	<div class="footer1">
		<form name="myForm" method="POST" action="#">
			<label for="email"></label>
			<input type="text" maxlength="8" name="userId" placeholder="User ID">

			<br>
			<label for="password"></label>
			<input type="password" maxlength="8" name="password" placeholder="Password">

			<div class="footer1">
				<input type="submit" class="button" title="Login" value="ログイン" onclick="login();">
			</div>

		</form>
	</div>

	<div class="footer2">
		FamilyMart
	</div>

</div>

</body>
</html>