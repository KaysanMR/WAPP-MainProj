<%@ Page Title="Lessons" Language="C#" MasterPageFile="~/Site.Master" 
    AutoEventWireup="true" CodeBehind="Lessons.aspx.cs" Inherits="MainProject.Lessons" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="Content/lessons.css" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <section class="lesson-background">
        <div class="container">
            <h2>Available Lessons</h2>
            <div class="lesson-grid">
                <asp:Repeater ID="lessonRepeater" runat="server">
                    <ItemTemplate>
                        <a class="lesson-card" href='<%# "LessonDetail.aspx?id=" + Eval("LessonId") %>'>
                            <%# Eval("Title") %>
                        </a>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>
</asp:Content>