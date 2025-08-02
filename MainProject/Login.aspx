<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" 
    CodeBehind="Login.aspx.cs" Inherits="MainProject.Login" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="Content/styles.css" />    
    <link rel="stylesheet" href="Content/login.css" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-container">
        <div class="form-container">
            <h2>Login</h2>

            <asp:Label ID="lblError" runat="server" CssClass="error" Visible="false" />

            <div class="form-group">
                <label for="username">Username</label>
                <asp:TextBox ID="username" runat="server" CssClass="input" />
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <asp:TextBox ID="password" runat="server" CssClass="input" TextMode="Password" />
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn" OnClick="btnLogin_Click" />

            <div class="register-link">
                Don't have an account? <a href="Register.aspx">Register here</a>
            </div>
        </div>
    </div>
</asp:Content>