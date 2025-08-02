<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Register.aspx.cs" Inherits="MainProject.Register" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="Content/login.css" />
    <style>
        .two-column-form {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-full-width {
            grid-column: span 2;
        }

        @media (max-width: 768px) {
            .two-column-form {
                grid-template-columns: 1fr;
            }

            .form-full-width {
                grid-column: span 1;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="login-container">
        <div class="form-container">
            <h2>Register</h2>

            <asp:Label ID="errMsg" runat="server" CssClass="error form-full-width" Visible="false" />

            <div class="two-column-form">

                <div class="form-group">
                    <label for="gender">Gender:</label>
                    <asp:DropDownList ID="gender" runat="server" CssClass="input">
                        <asp:ListItem>Male</asp:ListItem>
                        <asp:ListItem>Female</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-group">
                    <label for="country">Country:</label>
                    <asp:TextBox ID="country" runat="server" CssClass="input" />
                </div>

                <div class="form-group">
                    <label for="email">Email:</label>
                    <asp:TextBox ID="email" runat="server" TextMode="Email" CssClass="input" />
                </div>

                <div class="form-group">
                    <label for="username">Username:</label>
                    <asp:TextBox ID="username" runat="server" CssClass="input" />
                </div>

                <div class="form-group">
                    <label for="pwd">Password:</label>
                    <asp:TextBox ID="pwd" runat="server" TextMode="Password" CssClass="input" />
                </div>

                <div class="form-group">
                    <label for="pwd0">Confirm Password:</label>
                    <asp:TextBox ID="pwd0" runat="server" TextMode="Password" CssClass="input" />
                    <asp:CompareValidator ID="cv1" runat="server"
                        ControlToCompare="pwd"
                        ControlToValidate="pwd0"
                        ErrorMessage="Passwords do not match!"
                        CssClass="error"
                        Display="Dynamic" />
                </div>

                <div class="form-group form-full-width">
                    <label for="adminKey">Admin Key (optional):</label>
                    <asp:TextBox ID="adminKey" runat="server" TextMode="Password" CssClass="input" />
                </div>
            </div>

            <div class="form-full-width" style="text-align: center; margin-top: 20px;">
                <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn" OnClick="btnRegister_Click" />
            </div>

            <div class="register-link form-full-width">
                Already have an account? <a href="Login.aspx">Login here</a>
            </div>
        </div>
    </div>
</asp:Content>
