<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
.modal input[type=text],.modal input[type=password] {
    width: 100%;
    padding: 15px;
    margin: 5px 0 22px 0;
    display: inline-block;
    border: none;
    background: #f1f1f1;
}

/* Add a background color when the inputs get focus */
.modal input[type=text]:focus, .modal input[type=password]:focus {
    background-color: #ddd;
    outline: none;
}

/* Set a style for all buttons */
button {
    background-color: #4CAF50;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    cursor: pointer;
    width: 100%;
    opacity: 0.9;
}

button:hover {
    opacity:1;
}

/* Extra styles for the cancel button */
.cancelbtn {
    padding: 14px 20px;
    background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn, .signupbtn {
  float: left;
  width: 50%;
}

/* Add padding to container elements */
.container {
    padding: 16px ;
}

/* The Modal (background) */
.modal {
    display: none; /* Hidden by default */
    position: fixed; /* Stay in place */
    z-index: 1; /* Sit on top */
    left: 0;
    top: 0;
    width: 100%; /* Full width */
    height: 100%; /* Full height */
    overflow: auto; /* Enable scroll if needed */
    background-color: #474e5d;

}

/* Modal Content/Box */
.modal-content {
    background-color: #fefefe;
    margin: 2% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
    border: 1px solid #888;
    width: 80%; /* Could be more or less, depending on screen size */
}

/* Style the horizontal ruler */
hr {
    border: 1px solid #f1f1f1;
    margin-bottom: 25px;
}
 


/* Clear floats */
.clearfix::after {
    content: "";
    clear: both;
    display: table;
}
.clearfix button{
	color:white !important;
}
/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
    .cancelbtn, .signupbtn {
       width: 100%;
    }
}
@media (min-width:1200px){
	.modal-content{
		width:970px !important;
	}
	.modal-content .container{
		width:970px !important;
	}
	
}
#id_check{
	width:80px;
	position: absolute;
	right:15px;
}
</style>
<title>Insert title here</title>
<meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
    <!-- Bootstrap 3.3.4 -->
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Font Awesome Icons -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <!-- Ionicons -->
    <link href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" rel="stylesheet" type="text/css" />
    <!-- Theme style -->
    <link href="${pageContext.request.contextPath}/resources/dist/css/AdminLTE.min.css" rel="stylesheet" type="text/css" />
    <!-- AdminLTE Skins. Choose a skin from the css/skins 
         folder instead of downloading all of them to reduce the load. -->
    <link href="${pageContext.request.contextPath}/resources/dist/css/skins/_all-skins.min.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/resources/plugins/jQuery/jQuery-2.1.4.min.js"></script>
    <!-- Bootstrap 3.3.2 JS -->
    <script src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
    <!-- FastClick -->
    <script src='${pageContext.request.contextPath}/resources/plugins/fastclick/fastclick.min.js'></script>
    <!-- AdminLTE App -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/app.min.js" type="text/javascript"></script>
    <!-- AdminLTE for demo purposes -->
    <script src="${pageContext.request.contextPath}/resources/dist/js/demo.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function(){
		$("#join").click(function(){
			location.href="join";
		})
		$("#id_check").click(function(){
			var id=$("#joinid").val();
			var reg =/^(?=.*[A-Za-z])[A-Za-z0-9]{6,15}$/;
		    var reg2 = /^[A-Za-z]{6,15}$/;
			if(id == ""){
				alert("아이디를 입력해주세요");
				return;
			}else if(!reg.test(id) && !reg2.test(id)){
				alert("6자이상 15이하 영문,숫자를 입력해주세요");
				return;
			}
			$.ajax({
				url:"checkdWhihId",
				data:{id:id},
				type:"get",
				dataType:"text",
				success:function(result){
					if(result =="success"){
						$("#id_check").removeClass("btn-danger").addClass("btn-success");
						alert("사용가능한 아이디입니다.")
					}else{
						alert("중복된 아이디입니다.")
					}
				}
			})
		})
		
		$("#joinbtn").click(function(){
			var regpw =/^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,20}$/;
			var regName =/^[가-힣]{2,5}$/;
			if($("#id_check").hasClass("btn-danger")){
				alert("중복체크를 하세요");
				return false;
			}else if(!regpw.test($("#joinpw").val())){
				alert("비밀번호 8자이상20이하 영어,숫자,특수문자를 포함해주세요");
				return false;
			}else if($("#joinpw").val() !=$("#joinpw_repeat").val()){
				alert("비밀번호가 일치하지않습니다.");
				return false;
			}else if(!regName.test($("#joinname").val())){
				alert("이름을 2~5자 입력해주세요");
				return false;
			}
			var id=$("#joinid").val();
			var email=$("#joinemail").val();
			var password=$("#joinpw").val();
			var phone=$("#joinphone").val();
			var name=$("#joinname").val();
			$.ajax({
				url:"join",
				data:{id:id,email:email,password:password,phone:phone,name:name},
				type:"post",
				dataType:"text",
				success:function(result){
					if(result =="success"){
						$("#id01").css("display","none");
						alert("회원가입 되었습니다.")
					}else{
						alert("중복된 아이디입니다.")
					}
				}
			})
		})
	})
</script>
</head>

<body class="login-page">
<c:if test="${fail !=null}">
	<script type="text/javascript">
		alert("${fail }")
	</script>
</c:if>
	<div class="login-box">
		<div class="login-logo">
			<a href="#"><b>DGIT</b>Project</a>
		</div>
		<div class="login-box-body">
			<p class="login-box-msg">Sign in to start your session</p>
			
			<form action="login" method="post">
				<div class="form-group has-feedback">
					<input type="text" name="id" class="form-control" placeholder="USER ID">
					<span class="glyphicon glyphicon-user form-control-feedback"></span>
				</div>
				<div class="form-group has-feedback">
					<input type="password" name="pw" class="form-control" placeholder="Password">
					<span class="glyphicon glyphicon-lock form-control-feedback"></span>
				</div>
				<div class="row">
					<div class="col-xs-4 col-xs-offset-2">
						<button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
					</div>
					<div class="col-xs-4 ">
						<button type="button" class="btn btn-success btn-block btn-flat" onclick="document.getElementById('id01').style.display='block'">Sign Up</button>			
					</div>
				</div>
			</form>
		</div>
	</div>
<div id="id01" class="modal">
  <form class="modal-content" action="join" method="post" id="join_form">
    <div class="container">
      <h1>Sign Up</h1>
      <p>Please fill in this form to create an account.</p>
      <hr>
      <label for="id"><b>ID</b></label>
      <button class="btn btn-danger" id="id_check" type="button">중복체크</button>
      <input type="text" placeholder="Enter ID" name="id" required id="joinid" onkeyup="this.value=this.value.replace(/[^A-Za-z0-9]/g,'');">

      <label for="name"><b>Name</b></label>
      <input type="text" placeholder="Enter name" name="name" id="joinname" required onkeyup="this.value=this.value.replace(/[^가-힣]/g,'');">
	  <span></span>
      <label for="password"><b>Password</b></label>
      <input type="password" placeholder="Enter Password" name="password" id="joinpw" required>
		
      <label for="psw-repeat"><b>Repeat Password</b></label>
      <input type="password" placeholder="Repeat Password" name="psw-repeat" id="joinpw_repeat" required>
      
      <label for="psw"><b>Email</b></label>
      <input type="text" placeholder="Enter Email" name="email" id="joinemail" required>
      
      <label for="psw"><b>Phone</b></label>
      <input type="text" placeholder="Enter Phone" name="phone" id="joinphone" required onkeyup="this.value=this.value.replace(/[^0-9]/g,'');">
      <div class="clearfix">
        <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
        <button type="button" class="signupbtn" id="joinbtn">Sign Up</button>
      </div>
    </div>
  </form>
</div>

<script>
// Get the modal
var modal = document.getElementById('id01');

window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}
</script>
</body>
</html>