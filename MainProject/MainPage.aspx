<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="MainPage.aspx.cs" Inherits="MainProject.MainPage" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="Content/mainpage.css" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <!-- Hero Section -->
    <section class="hero">
        <div class="container">
            <div class="hero-text">
                <h1>Master the Digital World</h1>
                <p class="tagline">Smart. Safe. Strong.</p>
                <asp:HyperLink ID="btnGetStarted" runat="server" NavigateUrl="~/Lessons.aspx" CssClass="cta-button">
                    Start Learning Today
                </asp:HyperLink>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="container">
            <h2>What You'll Learn</h2>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">💻</div>
                    <h3>Computer Basics</h3>
                    <p>From turning on a computer to file management</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">🌐</div>
                    <h3>Internet Safety</h3>
                    <p>Browse safely and avoid online scams</p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h3>Smartphone Skills</h3>
                    <p>Master your mobile device with confidence</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonial Section -->
    <section class="testimonial">
        <div class="container">
            <blockquote>
                "NetSmart helped my 72-year-old mother video call her grandchildren for the first time!"
               
                <cite>- Sarah J., Daughter</cite>
            </blockquote>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="faq">
        <div class="container">
            <h2>Frequently Asked Questions</h2>
            <div class="faq-item">
                <div class="faq-question">Do I need any experience to start?</div>
                <div class="faq-answer">
                    <p>No prior experience needed! We start with absolute basics.</p>
                </div>
            </div>
            <div class="faq-item">
                <div class="faq-question">What equipment do I need?</div>
                <div class="faq-answer">
                    <p>Just a computer or smartphone with internet access.</p>
                </div>
            </div>
            <div class="faq-item">
                <div class="faq-question">Is there any cost?</div>
                <div class="faq-answer">
                    <p>All our basic lessons are completely free!</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta">
        <div class="container">
            <h2>Ready to Begin Your Digital Journey?</h2>
            <asp:HyperLink ID="btnCta" runat="server" NavigateUrl="~/Register.aspx" CssClass="cta-button">
                Join Now - It's Free!
            </asp:HyperLink>
        </div>
    </section>
</asp:Content>

<asp:Content ID="Scripts" ContentPlaceHolderID="Scripts" runat="server">
    <script>
        // FAQ toggle functionality
        document.querySelectorAll('.faq-question').forEach(question => {
            question.addEventListener('click', (e) => {
                e.preventDefault(); // Prevent default behavior
                const answer = question.nextElementSibling;
                const isActive = question.classList.contains('active');

                // Close all other FAQs
                document.querySelectorAll('.faq-question').forEach(q => {
                    if (q !== question) {
                        q.classList.remove('active');
                        q.nextElementSibling.style.display = 'none';
                    }
                });

                // Toggle current FAQ
                question.classList.toggle('active');
                answer.style.display = isActive ? 'none' : 'block';
            });
        });
    </script>
</asp:Content>
