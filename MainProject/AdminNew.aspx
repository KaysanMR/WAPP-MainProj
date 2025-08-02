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
            <div class="stat-card">
                <span class="stat-label">Total Users</span>
                <span class="stat-value"><asp:Label ID="lblTotalUsers" runat="server" /></span>
            </div>
        </div>

        <!-- Analytics Charts -->
        <div class="analytics-section">
            <h2>Analytics Charts</h2>
            <div class="chart-container">
                <div class="chart-card">
                    <h3>User Activity</h3>
                    <canvas id="pieChart"></canvas>
                </div>
                <div class="chart-card large-bar-chart">
                    <h3>Lesson Views</h3>
                    <canvas id="lessonBarChart"></canvas>
                </div>
                <div class="chart-card">
                    <h3>Answer Accuracy</h3>
                    <canvas id="correctChart"></canvas>
                </div>
                <div class="chart-card large-bar-chart">
                    <h3>Lesson Views</h3>
                    <canvas id="lessonBarChart1"></canvas>
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
                        backgroundColor: ['#FFD700', '#555']
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom',
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

            // Doughnut Chart - Answer Accuracy
            new Chart(document.getElementById('correctChart'), {
                type: 'doughnut',
                data: {
                    labels: ['Correct', 'Incorrect'],
                    datasets: [{
                        data: correctData,
                        backgroundColor: ['#FFD700', '#8b0000']
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'bottom',
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
        };
    </script>
</asp:Content>