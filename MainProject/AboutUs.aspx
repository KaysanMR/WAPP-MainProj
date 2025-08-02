<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="AboutUs.aspx.cs" Inherits="MainProject.AboutUs" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="Content/aboutus.css" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="about">
        <div class="container">
            <div class="row">
                <div class="about-col-1">
                    <img src="img/AboutUs.jpg" class="photo-about" alt="About us photo">
                </div>
                <div class="about-col-2">
                    <h1 class="sub-title">About Us</h1>
                    <p>
                        Welcome to <strong>NetSmart</strong>, your friendly guide to digital confidence! Founded in 2025, we help newcomers build essential computer skills in a judgment-free environment. Whether you're learning to send your first email, video call family, or stay safe online, we make technology simple and approachable.
       
                       

                        <br>
                        <br>
                        Our patient, step-by-step teaching method helps seniors, tech beginners, and anyone feeling left behind in our digital world. We believe everyone deserves to participate confidently in today's connected society - no prior experience needed!
       
                       

                        <br>
                        <br>
                        At NetSmart, we replace confusion with confidence through free resources, in-person workshops, and personalized coaching. Your digital journey starts here!
                   
                    </p>
                    <div class="tab-skills">
                        <p class="tab-links active-link" onclick="openTab('skills')">Learn the Basics</p>
                        <p class="tab-links" onclick="openTab('experience')">Our Workshops</p>
                        <p class="tab-links" onclick="openTab('education')">Meet the Team</p>
                    </div>
                    <div class="tab-contents active-tab" id="skills">
                        <ul>
                            <li><span>Computer Essentials:</span> Mouse/keyboard skills, file management, basic troubleshooting</li>
                            <li><span>Internet Fundamentals:</span> Safe browsing, email setup, avoiding online scams</li>
                            <li><span>Smartphone Basics:</span> App installation, video calls, mobile security</li>
                            <li><span>Daily Digital Tools:</span> Online forms, video conferencing, digital payments</li>
                        </ul>
                    </div>
                    <div class="tab-contents" id="experience">
                        <ul>
                            <li><span>Free Community Classes:</span> Weekly sessions at local libraries (all ages welcome)</li>
                            <li><span>"Tech Buddies" Program:</span> 1-on-1 coaching for personalized learning</li>
                            <li><span>Senior Digital Cafés:</span> Social learning groups with refreshments</li>
                            <li><span>Online Video Library:</span> 50+ step-by-step tutorials (accessible anytime)</li>
                        </ul>
                    </div>
                    <div class="tab-contents" id="education">
                        <ul>
                            <li><span>Our Instructors:</span> Patient teachers with 5+ years experience in adult education</li>
                            <li><span>Teaching Philosophy:</span> "Go at your pace" methodology with zero tech jargon</li>
                            <li><span>Community Focus:</span> Partnered with 15+ local organizations to bridge the digital divide</li>
                            <li><span>Credentials:</span> Google Digital Literacy certified • CompTIA ITF+ • AARP Digital Skills trained</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
    <script>
        function openTab(tabName) {
            let tabLinks = document.getElementsByClassName("tab-links");
            let tabContents = document.getElementsByClassName("tab-contents");
            for (let link of tabLinks) {
                link.classList.remove("active-link");
            }
            for (let content of tabContents) {
                content.classList.remove("active-tab");
            }
            event.currentTarget.classList.add("active-link");
            document.getElementById(tabName).classList.add("active-tab");
        }
    </script>
</asp:Content>
