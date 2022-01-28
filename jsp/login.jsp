<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link href="../static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="../static/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="../static/bootstrap/js/jquery-3.3.1.min.js"></script>
    <script src="../static/bootstrap/js/bootstrap.min.js"></script>
    <script src="../static/js/Api.js"></script>
    <link rel="icon" type="image/x-icon" href="../static/images/logo.ico"/>
    <link href="../static/css/login.css" rel="stylesheet">

    <script></script>
    <title>log in Register</title>
</head>
<body>

    <!-- ------------------------------------------------------------------- -->
    <div class="screen">
        <label class="title">Movie booking</label><br/>
    </div>
    <!-- 登录页 -->
    <div class="content" style="float: left;">
        <ul class="tab">
            <li class="login">log in</li>
            <li class="register">registered</li>
        </ul>
        <div class="page">
            <!-- 登录界面 -->
            <div class="childpage" style="display: block">
                <div>
                    <label class="login_title">User login</label><br/>
                </div>
                <div class="login_page">
                    <div>
                        <label>account number</label><br/>
                        <input id="UserName" type="text"/>
                    </div>
                    <div>
                        <label>password</label><br/>
                        <input id="PassWord" type="password"/>
                    </div>
                </div>
                <div class="lo_error">
                    <label class="login_error"></label>
                </div>
                <div>
                    <input type="button" value="log in" class="btn btn-success login_btn" onclick="loginbtn()"/>
                </div>
                <div>
                    <label class="login_version">@all rights reserved</label>
                </div>
            </div>
            <!-- 注册界面 -->
            <div class="childpage" style="display: none">
                <div>
                    <label class="register_title">User registration</label><br/>
                </div>
                <div class="register_page">
                    <div>
                        <label>account number</label><br/>
                        <input id="UserName" type="text"/>
                    </div>
                    <div>
                        <label>password</label><br/>
                        <input id="PassWord" type="password"/>
                    </div>
                    <div>
                        <label>mailbox</label><br/>
                        <input id="Email" type="text"/>
                    </div>
                    <div>
                        <label>verification code</label><br/>
                        <input id="Test" type="text"/>
                        <input id="TestNum" type="button"/>
                    </div>
                </div>
                <div class="re_error">
                    <label class="register_error"></label>
                </div>
                <div>
                    <input type="button" value="registered" class="btn btn-warning register_btn" onclick="registerbtn()"/>
                </div>
                <div>
                    <label class="register_version">@all rights reserved</label>
                </div>
            </div>
        </div>
        
    </div>

    <!-- ------------------------------------------------------------------- -->
    <script>
        //初始化
        window.onload = function(){ 
            initWindow(); //初始化登录框位置
            initLogin(); //初始化登录界面
        }

        //初始化登录框位置（垂直居中、水平4/7）
        function initWindow(){
            var middle = 3;
            var colorNum = 200;
            var clientHeight = document.documentElement.clientHeight;
            var clientWidth = document.documentElement.clientWidth;
            var content = document.getElementsByClassName('content')[0];
            var screen = document.getElementsByClassName('screen')[0];
            var title = document.getElementsByClassName('title')[0];
            var bodys = document.getElementsByTagName('body')[0];
            bodys.style.cssText = "background-size: " + clientWidth + "px auto;";
            content.style.cssText = "margin:" + (clientHeight - content.clientHeight)/2 +"px " + 
            clientWidth*4/7 + "px " +
            (clientHeight - content.clientHeight)/2 + "px;";
            screen.style.cssText = "margin:" + (content.clientHeight - screen.clientHeight)/2 +"px " + 
            (clientWidth*4/7 - screen.clientWidth)/2 + "px " +
            (content.clientHeight - screen.clientHeight)/2 + "px;";
            setInterval(function(){
                colorNum += middle;
                if(colorNum>185){
                    middle = -3;
                }else if(colorNum<80){
                    middle = 3;
                }
                title.style.cssText = "color:rgb(255," + colorNum + ", 0)";
            },30);
        }

        //初始化登录界面
        function initLogin(){
            var textNum = document.getElementById('TestNum');
            var liArr = document.getElementsByTagName('li');
    		var divArr = document.getElementsByClassName("page")[0].getElementsByClassName("childpage");
            textNum.onclick = function(){
                textNum.value = TestNum();
            }
    		for(var i=0;i<liArr.length;i++){
    			liArr[i].index = i;
    			liArr[i].onclick = function(){
                    textNum.value = TestNum();
    				for(var j=0;j<divArr.length;j++){
                        liArr[j].style.cssText = "background-color:rgba(255, 255, 255, 0.2);";
    					divArr[j].style.display = "none";
    				}
                    liArr[this.index].style.cssText = "background-color:rgba(255, 255, 255, 0);";
    				divArr[this.index].style.display = "block";
    			}
    		}
        }
        
        //更新验证码
        function TestNum(){
            var testNum = "";
            var selectChar = new Array(0,1,2,3,4,5,6,7,8,9,'a','b','c','d','e','f','g','h','i','j','k','l',
                'm','n','o','p','q','r','s','t','u','v','w','x','y','z');
            for(var i=0;i<4;i++){
                var charIndex = Math.floor(Math.random()*36);
                testNum +=selectChar[charIndex];
            }
            return testNum;
        }

         //登录账号和密码信息验证
         function loginbtn(){
            var user_name = $(".login_page").find("#UserName").val();
            var user_pwd = $(".login_page").find("#PassWord").val();
            var login_error = $(".login_error");
            if((user_name == "") || (user_pwd == "")){
                login_error.text("Account and password cannot be empty");
            }
            else{
                login_error.text("");
                $.ajax({
                    type: "post",
                    url: "/user",
                    data: {
                    	method:'login',
                        user_name: user_name,
                        user_pwd: user_pwd
                    },
                    dataType: "json",
                    success: function(obj){
                        if(obj.msg == "fail"){
                           // sessionStorage.removeItem('userJson');
                            login_error.text('Incorrect username or password!');
                        }
                        else{
                            localStorage.setItem("userJson",JSON.stringify(obj.data));
                          // sessionStorage.set
                            window.location.href="/jsp/mainPage.jsp";
                        }
                    },
                    error:function(){
                        alert("network error!");
                    }
                });
            }
        }

        //注册账号和密码逻信息验证
        function registerbtn(){
            var textNum = document.getElementById('TestNum'); 
            var user_name = $(".register_page").find("#UserName").val();
            var user_pwd = $(".register_page").find("#PassWord").val();
            var user_email = $(".register_page").find("#Email").val();
            var register_error = $(".register_error");
            var test = $("#Test").val();
            var testbtn = $("#TestNum").val();
            var patrn=/^([a-zA-Z0-9]){0,7}$/;
            if (!patrn.exec(user_name)){
            	register_error.text("Account can only enter 1-8 strings");
                textNum.value = TestNum();
                return;
            }
            var patrnPwd=/^([a-zA-Z0-9]){2,9}$/;
            if (!patrnPwd.exec(user_pwd)){
            	register_error.text("Password can only enter 3-10 strings");
                textNum.value = TestNum();
                return;
            }
            if((user_name == "") || (user_pwd == "") || (user_email == "")){
                register_error.text("Account, password and email cannot be empty");
                textNum.value = TestNum();
            }
            
            else if((test == "") || test!=testbtn){
                register_error.text("Verification code error");
                textNum.value = TestNum();
            }
            else{
                register_error.text("");
                $.ajax({
                    type: "post",
                    url: url + "/user",
                    data: {
                    	method:'register',
                        user_name: user_name,
                        user_pwd: user_pwd,
                        user_email: user_email
                    },
                    dataType: "json",
                    success: function(data){
                        console.log(data);
                        if(data.state == "success"){
                            window.alert("registration success！");
                            window.location.href="/jsp/login.jsp";
                        }else{
                            register_error.text('The account has been registered!');
                        }
                    }
                });
            }
        }

    </script>
    <!-- ------------------------------------------------------------------- -->
</body>
</html>