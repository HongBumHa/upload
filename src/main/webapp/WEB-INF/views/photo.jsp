<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<title>Insert title here</title>
<style>
	#h21{
		position: relative;
	}
	#upload_img{
		text-decoration:none;
		font-size:14px;
		position:absolute;
		right:5px;
		top:15px;
		color:skyblue;
		cursor: pointer;
	}
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
#preview{
	width:100%;
	height:500px;
	overflow:hidden;
}
.imgdiv{
	width:150px;
	height:150px;
	border:1px solid black;
	position: relative;
	float:left;
}
.imgdiv button.btn1{
	position: absolute;
	top:5px;
	right:5px;
	color:black;
	width:20px;
	height:20px;
	padding:0;
	margin:0;
}
.imgdiv img{
	max-width:150px;
	max-height:150px;
	padding:5px;
}
.listdiv{
	position: relative;
	padding:5px;
	width:150px;
	height:200px;
	text-align: center;
}
.listdiv button{
	position: absolute;
	top:0;
	right:0;
	color:black;
	width:20px;
	height:20px;
	padding:0;
	background:#ccc;
	margin:0;
}
.listdiv img{
	max-width:150px;
	max-height:150px;
	padding:5px;
	
}
#bigImgDiv{
	width:100%;
	height:100%;
	text-align: center;
	display: none;
}
#logout{
	text-align: right;
	cursor: pointer;
}
</style>
<script type="text/javascript">
var id = "${id}";
$(function(){
	imglist(id);
	$("#upload_img").click(function(){
		$("#id01").css("display","block");
	});
	$("#files").change(function(){
		var index = 1;
		$("#preview").empty();
		var file = document.getElementById("files");
		
		var reader = new FileReader();
		reader.onload = function(e){
			var imgObj = $("<img>").attr("src",e.target.result);	
			var divObj = $("<div>").addClass("imgdiv").append(imgObj);
			$("#preview").append(divObj);
		}
		reader.readAsDataURL(file.files[0]);
		reader.onloadend = function(e){
			if(index >= file.files.length){
				index = 1;
				return;
			}
			reader.readAsDataURL(file.files[index]);
			index += 1;
		}
	});
	$(document).on("click",".delBtn",function(){
		if(confirm("삭제하시겠습니까?")){
			var imgsrc = $(this).parent().find("img").attr("src");
			$(this).parent().remove();
			var filename = imgsrc.substr(imgsrc.indexOf("=")+1,imgsrc.length);
			$.ajax({
				url:"deleteFile",
				type:"get",
				data:{filename:filename,id:id},
				dataType:"text",
				success:function(result){
					console.log(result)
					
					if(result=="Success"){
						imglist(id);
					}else{
						alert("오류");
					}
				}
			})
		}
		
	})
	$("#logout").click(function(){
		location.href="logout"
	})
	$(document).on("click",".imgclick",function(){
		var bigImg = $(this).attr("src").replace("s_","");
		$("#bigImgDiv").css("display","block");
		$("#bigImg").attr("src",bigImg);
		
	});
	$("#bigImg").click(function(){
		$("#bigImgDiv").css("display","none");
	});
})
function imglist(id){
	$.ajax({
		url:"photolist",
		type:"get",
		data:{id:id},
		dataType:"json",
		success:function(json){
			console.log(json);
			$("#t_tbody").empty();
			$("#t_tbody").append("<tr>");
			if(json.length !=0){
				for(var i =0; i < json.length; i++){
					var img = $("<img>").attr("src","displayFile?filename="+json[i].fullName).addClass("imgclick");
					var filetext = json[i].fullName.substring(json[i].fullName.lastIndexOf("_")+1,json[i].fullName.length);
					var p = $("<p>").text(filetext);
					var data = new Date(json[i].regdate);
					var p1 = $("<p>").text(data.toLocaleDateString());
					var btn = $("<button>").text("X").addClass("delBtn");
					var div = $("<div>").append(img).append(btn).append(p).append(p1).addClass("listdiv");
					if(i % 3 == 0 ){
						$("#t_tbody").append("</tr><tr><td>").append(div).append("</td>");
					}else{
						$("#t_tbody").append("<td>").append(div).append("</td>");
					}
					if(i+1 == json.length){
						$("#t_tbody").append("</tr>")
					}
				}
				
			}
			
		}
	})
}
</script>
</head>
<body>
	<div class="container">
		<h2 id="h21">사진 관리 <span id="upload_img">사진 추가하기</span></h2>
		<h4 id="logout">로그아웃</h4>
		<table class="table">
			<tbody id="t_tbody">
				
			</tbody>
		</table>
	</div>
<div id="bigImgDiv">
	<img id="bigImg">
</div>
<div id="id01" class="modal">
  <form class="modal-content" action="upload" method="post" id="upload_form" enctype="multipart/form-data">
    <div class="container">
      <h1>Upload</h1>
      <hr>
      <label for="files"><b>사진선택</b></label>
      <input type="file" name="files" multiple="multiple" id="files" accept="image/*">
      <input type="hidden" name="id" value="${id }">
      <div id="preview">
      	
      </div>
      <div class="clearfix">
        <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">Cancel</button>
        <button type="submit" class="signupbtn" id="insertbtn">Upload</button>
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