<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/AdminMaster.Master"
    AutoEventWireup="true" CodeBehind="AdminNew.aspx.cs" Inherits="MainProject.AdminNew" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="Content/adminnew.css" />
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="admin-container">
        <div class="dashboard-header">
            <h1>Admin Dashboard</h1>

            <div class="stats-container">
                <!-- Total Users Card -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M4.5 6.375a4.125 4.125 0 118.25 0 4.125 4.125 0 01-8.25 0zM14.25 8.625a3.375 3.375 0 116.75 0 3.375 3.375 0 01-6.75 0zM1.5 19.125a7.125 7.125 0 0114.25 0v.003l-.001.119a.75.75 0 01-.363.63 13.067 13.067 0 01-6.761 1.873c-2.472 0-4.786-.684-6.76-1.873a.75.75 0 01-.364-.63l-.001-.122zM17.25 19.128l-.001.144a2.25 2.25 0 01-.233.96 10.088 10.088 0 005.06-1.01.75.75 0 00.42-.643 4.875 4.875 0 00-6.957-4.611 8.586 8.586 0 011.71 5.157v.003z" />
                        </svg>
                    </div>
                    <div class="stat-content">
                        <span class="stat-label">Total Users</span>
                        <span class="stat-value">
                            <asp:Label ID="lblTotalUsers" runat="server" Text="0" /></span>
                    </div>
                </div>

                <!-- Total Lessons Completed Card -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                            <path fill-rule="evenodd" d="M8.603 3.799A4.49 4.49 0 0112 2.25c1.357 0 2.573.6 3.397 1.549a4.49 4.49 0 013.498 1.307 4.491 4.491 0 011.307 3.497A4.49 4.49 0 0121.75 12a4.49 4.49 0 01-1.549 3.397 4.491 4.491 0 01-1.307 3.497 4.491 4.491 0 01-3.497 1.307A4.49 4.49 0 0112 21.75a4.49 4.49 0 01-3.397-1.549 4.49 4.49 0 01-3.498-1.306 4.491 4.491 0 01-1.307-3.498A4.49 4.49 0 012.25 12c0-1.357.6-2.573 1.549-3.397a4.49 4.49 0 011.307-3.497 4.49 4.49 0 013.497-1.307zm7.007 6.387a.75.75 0 10-1.22-.872l-3.236 4.53L9.53 12.22a.75.75 0 00-1.06 1.06l2.25 2.25a.75.75 0 001.14-.094l3.75-5.25z" clip-rule="evenodd" />
                        </svg>
                    </div>
                    <div class="stat-content">
                        <span class="stat-label">Total Lessons Completed</span>
                        <span class="stat-value">
                            <asp:Label ID="lblTotalLessons" runat="server" Text="0" /></span>
                    </div>
                </div>

                <!-- Top Learner Card -->
                <div class="stat-card">
                    <div class="stat-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
                            <path fill-rule="evenodd" d="M10.788 3.21c.448-1.077 1.976-1.077 2.424 0l2.082 5.006 5.404.434c1.164.093 1.636 1.545.749 2.305l-4.117 3.527 1.257 5.273c.271 1.136-.964 2.033-1.96 1.425L12 18.354 7.373 21.18c-.996.608-2.231-.29-1.96-1.425l1.257-5.273-4.117-3.527c-.887-.76-.415-2.212.749-2.305l5.404-.434 2.082-5.005z" clip-rule="evenodd" />
                        </svg>
                    </div>
                    <div class="stat-content">
                        <span class="stat-label">Top Learner</span>
                        <span class="stat-value">
                            <asp:Label ID="lblTopLearner" runat="server" Text="-" /></span>
                        <span class="stat-subtext">Most lessons completed recently</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Analytics Charts -->
        <div class="analytics-section">
            <h2>Analytics Charts</h2>
            <div class="chart-container">
                <div class="card">
                    <h3>User Activity</h3>
                    <canvas id="pieChart"></canvas>
                </div>
                <div class="card">
                    <h3>Course Completion</h3>
                    <canvas id="completionChart"></canvas>
                    <asp:Literal ID="LitCompletionClient" runat="server" Visible="false" />
                </div>
                <div class="card large-bar-chart">
                    <h3>Lesson Completions</h3>
                    <canvas id="lessonBarChart"></canvas>
                </div>
                <div class="card large-bar-chart">
                    <h3>Lesson Answer Accuracy</h3>
                    <canvas id="answerBarChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Hidden literals for JS charts -->
        <asp:Literal ID="litPieDataClient" runat="server" Visible="false" />
        <asp:Literal ID="litLessonLabelsClient" runat="server" Visible="false" />
        <asp:Literal ID="litLessonViewsClient" runat="server" Visible="false" />
        <asp:Literal ID="litCorrectIncorrectClient" runat="server" Visible="false" />

        <!-- User Progress Table -->
        <div class="card">
            <h2>Recently Completed</h2>
            <asp:GridView ID="GridViewProgress" runat="server" AutoGenerateColumns="true"
                CssClass="admin-grid"
                GridLines="None"
                HeaderStyle-CssClass="grid-header"
                RowStyle-CssClass="grid-row" />
        </div>

        <!-- Lesson Completion Stats Table -->
        <div class="card">
            <h2>Lesson Completion Stats</h2>
            <asp:GridView ID="GridViewLessonStats" runat="server" AutoGenerateColumns="true"
                CssClass="admin-grid"
                GridLines="None"
                HeaderStyle-CssClass="grid-header"
                RowStyle-CssClass="grid-row" />
        </div>

    </div>

    <script>
        console.log('Pie Data:', [<%= litPieDataClient.Text %>]);
        console.log('Bar Labels:', [<%= litLessonLabelsClient.Text %>]);
        console.log('Bar Data:', [<%= litLessonViewsClient.Text %>]);
        console.log('Completion Data:', document.getElementById('<%= LitCompletionClient.ClientID %>')?.textContent);

        function toggleFullscreen(el) {
            el.classList.toggle("fullscreen");
        }

        window.onload = function () {
            const pieData = [<%= litPieDataClient.Text %>];
            const barLabels = [<%= litLessonLabelsClient.Text %>];
            const barData = [<%= litLessonViewsClient.Text %>];
            const correctData = [<%= litCorrectIncorrectClient.Text %>];

            // Pie Chart - User Activity
            new Chart(document.getElementById('pieChart'), {
                type: 'pie',
                data: {
                    labels: ['Active Users', 'Inactive Users'],
                    datasets: [{
                        data: pieData,
                        backgroundColor: ['#FFD700', '#EEA400']
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {
                                color: '#eee',
                                font: {
                                    family: 'Poppins'
                                }
                            }
                        }
                    }
                }
            });

            // Bar Chart - Lesson Views
            new Chart(document.getElementById('lessonBarChart'), {
                type: 'bar',
                data: {
                    labels: barLabels,
                    datasets: [{
                        label: 'Views',
                        data: barData,
                        backgroundColor: '#FFD700'
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                color: '#fff',
                                font: {
                                    family: 'Poppins'
                                }
                            },
                            grid: {
                                color: '#444'
                            }
                        },
                        x: {
                            ticks: {
                                color: '#fff',
                                font: {
                                    family: 'Poppins'
                                }
                            },
                            grid: {
                                display: false
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: '#fff',
                                font: {
                                    family: 'Poppins'
                                }
                            }
                        }
                    }
                }
            });

            // Course Completion Chart - Fixed version
            const completionDataElement = document.getElementById('<%= LitCompletionClient.ClientID %>');
            if (completionDataElement && completionDataElement.textContent) {
                const completionData = completionDataElement.textContent.split(',').map(item => parseInt(item.trim()));

                // Check if we have valid data
                if (completionData.length === 2 && !isNaN(completionData[0]) && !isNaN(completionData[1])) {
                    new Chart(document.getElementById('completionChart'), {
                        type: 'doughnut',
                        data: {
                            labels: ['Completed All Courses', 'Completed Some Courses'],
                            datasets: [{
                                data: completionData,
                                backgroundColor: ['#FFD700', '#8b0000'],
                                borderColor: '#1a1a1a',
                                borderWidth: 2
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        color: '#fff',
                                        font: {
                                            family: 'Poppins'
                                        }
                                    }
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function (context) {
                                            const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                            const value = context.raw;
                                            const percentage = Math.round((value / total) * 100);
                                            return `${context.label}: ${value} (${percentage}%)`;
                                        }
                                    }
                                }
                            },
                            cutout: '70%'
                        }
                    });
                } else {
                    console.error('Invalid completion data format');
                }
            } else {
                console.error('Completion data element not found or empty');
            }
        };
    </script>
</asp:Content>
