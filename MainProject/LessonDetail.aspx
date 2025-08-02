<%@ Page Title="Lesson" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="LessonDetail.aspx.cs" Inherits="MainProject.LessonDetail" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="Content/lesson.css" />
    <style>
        /* Article section styles */
        .article-section {
            margin: 30px 0;
            padding: 20px;
            background-color: #111;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-left: 4px solid #ffd700;
        }

        .article-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            border-bottom: 1px solid #dee2e6;
            padding-bottom: 10px;
        }

        .article-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #ededed;
        }

        .article-meta {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .article-content {
            line-height: 1.7;
            font-size: 1.1rem;
            color: #ededed;
            max-height: 500px;
            overflow-y: auto;
            transition: max-height 0.5s ease;
        }

            .article-content.collapsed {
                max-height: 0;
                overflow: hidden;
            }

            .article-content h3 {
                margin-top: 20px;
                color: #ddd;
                border-bottom: 1px solid #e9ecef;
                padding-bottom: 5px;
            }

            .article-content ul, .article-content ol {
                padding-left: 25px;
                margin-bottom: 15px;
            }

            .article-content li {
                margin-bottom: 8px;
            }

            .article-content blockquote {
                background-color: #645717;
                border-left: 4px solid #ffd700;
                padding: 10px 15px;
                margin: 15px 0;
                font-style: italic;
            }

            .article-content pre {
                background-color: #2d3748;
                color: #e2e8f0;
                padding: 15px;
                border-radius: 5px;
                overflow-x: auto;
                margin: 15px 0;
            }

            .article-content code {
                background-color: #edf2f7;
                padding: 2px 6px;
                border-radius: 3px;
                font-family: 'Courier New', monospace;
            }

            /* Table styling for article content */
            .article-content table {
                width: 100%;
                border-collapse: collapse;
                margin: 25px 0;
                background-color: #0a0a0a;
                border: 1px solid #ffd700;
                box-shadow: 0 0 15px rgba(255, 215, 0, 0.2);
                border-radius: 6px;
                overflow: hidden;
            }

                .article-content table thead {
                    background: linear-gradient(to bottom, #2a2100, #1a1400);
                    border-bottom: 2px solid #ffd700;
                }

                .article-content table th {
                    padding: 15px;
                    text-align: left;
                    color: #ffd700;
                    font-weight: 600;
                    text-transform: uppercase;
                    letter-spacing: 1px;
                    font-size: 1.1rem;
                    border-right: 1px solid rgba(255, 215, 0, 0.3);
                }

                    .article-content table th:last-child {
                        border-right: none;
                    }

                .article-content table tbody tr {
                    border-bottom: 1px solid rgba(255, 215, 0, 0.2);
                    transition: background-color 0.3s ease;
                }

                    .article-content table tbody tr:last-child {
                        border-bottom: none;
                    }

                    .article-content table tbody tr:nth-child(even) {
                        background-color: rgba(30, 30, 30, 0.5);
                    }

                    .article-content table tbody tr:hover {
                        background-color: rgba(255, 215, 0, 0.1);
                    }

                .article-content table td {
                    padding: 12px 15px;
                    color: #e0e0e0;
                    border-right: 1px solid rgba(255, 215, 0, 0.1);
                }

                    .article-content table td:last-child {
                        border-right: none;
                    }

                .article-content table tfoot {
                    border-top: 2px solid #ffd700;
                    background: linear-gradient(to top, #2a2100, #1a1400);
                }

                    .article-content table tfoot td {
                        padding: 12px 15px;
                        color: #ffd700;
                        font-style: italic;
                    }

        .article-toggle {
            background: none;
            border: none;
            color: #ffd700;
            cursor: pointer;
            font-weight: 600;
            padding: 0;
            margin-top: 10px;
            display: flex;
            align-items: center;
            gap: 5px;
        }

            .article-toggle:hover {
                text-decoration: underline;
            }

            .article-toggle i {
                font-size: 0.8rem;
            }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="lesson-container">
        <h2>
            <asp:Label ID="lblTitle" runat="server" /></h2>

        <video controls runat="server" id="lessonVideo" class="lesson-video"></video>

        <!-- Article Section -->
        <div class="article-section" id="articleSection" runat="server">
            <div class="article-header">
                <h3 class="article-title">
                    <asp:Label ID="lblArticleTitle" runat="server" /></h3>
                <div class="article-meta">
                    By
                    <asp:Label ID="lblAuthor" runat="server" />
                    | 
                    Updated:
                    <asp:Label ID="lblLastUpdated" runat="server" />
                </div>
            </div>

            <div class="article-content" id="articleContent" runat="server"></div>

            <button type="button" class="article-toggle" id="btnToggleArticle">
                <i id="toggleIcon">▼</i>
                <span id="toggleText">Collapse Article</span>
            </button>
        </div>

        <!-- Quiz Section -->
        <div class="quiz-section">
            <h3>Test Your Knowledge</h3>

            <!-- Question 1 -->
            <div class="question-block">
                <label>
                    <asp:Label ID="lblQ1" runat="server" /></label>
                <div class="aspNetRadioButtonList">
                    <asp:RadioButtonList ID="rblQ1" runat="server" RepeatDirection="Vertical"
                        CssClass="radioList" RepeatLayout="Flow" />
                </div>
            </div>

            <!-- Question 2 -->
            <div class="question-block">
                <label>
                    <asp:Label ID="lblQ2" runat="server" /></label>
                <div class="aspNetRadioButtonList">
                    <asp:RadioButtonList ID="rblQ2" runat="server" RepeatDirection="Vertical"
                        CssClass="radioList" RepeatLayout="Flow" />
                </div>
            </div>

            <!-- Question 3 -->
            <div class="question-block">
                <label>
                    <asp:Label ID="lblQ3" runat="server" /></label>
                <div class="aspNetRadioButtonList">
                    <asp:RadioButtonList ID="rblQ3" runat="server" RepeatDirection="Vertical"
                        CssClass="radioList" RepeatLayout="Flow" />
                </div>
            </div>

            <!-- Submit Button -->
            <div class="submit-section">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit Answers" CssClass="btn" OnClick="btnSubmit_Click" />
            </div>

            <!-- Feedback Message -->
            <asp:Label ID="lblFeedback" runat="server" CssClass="feedback" />
        </div>

        <!-- Navigation -->
        <div class="nav-buttons">
            <asp:Button ID="btnPrev" runat="server" Text="◀ Previous Lesson" CssClass="btn" OnClick="btnPrev_Click" />
            <asp:Button ID="btnHome" runat="server" Text="🏠 Back to Lessons" CssClass="btn" OnClick="btnHome_Click" />
            <asp:Button ID="btnNext" runat="server" Text="Next Lesson ▶" CssClass="btn" OnClick="btnNext_Click" />
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const toggleBtn = document.getElementById('btnToggleArticle');
            const content = document.getElementById('<%= articleContent.ClientID %>');
            const toggleText = document.getElementById('toggleText');
            const toggleIcon = document.getElementById('toggleIcon');

            // Check if article exists
            if (content.innerHTML.trim() !== '') {
                // Toggle functionality
                toggleBtn.addEventListener('click', function () {
                    content.classList.toggle('collapsed');

                    if (content.classList.contains('collapsed')) {
                        toggleText.textContent = 'Expand Article';
                        toggleIcon.textContent = '►';
                    } else {
                        toggleText.textContent = 'Collapse Article';
                        toggleIcon.textContent = '▼';
                    }
                });
            } else {
                // Hide toggle button if no article
                toggleBtn.style.display = 'none';
            }
        });
    </script>
</asp:Content>
