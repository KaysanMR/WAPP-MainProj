<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/AdminMaster.Master"
    AutoEventWireup="true" CodeBehind="AdminNew.aspx.cs" Inherits="MainProject.AdminNew" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
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
                    <canvas id="pieChart" width="400" height="300"></canvas>
                </div>
                <div class="card">
                    <h3>Course Completion</h3>
                    <canvas id="completionChart" width="400" height="300"></canvas>
                </div>
                <div class="card large-bar-chart">
                    <h3>Lesson Completions</h3>
                    <canvas id="lessonBarChart" width="600" height="400"></canvas>
                </div>
                <div class="card large-bar-chart">
                    <h3>Lesson Answer Accuracy</h3>
                    <canvas id="answerBarChart" width="600" height="400"></canvas>
                </div>
            </div>
        </div>
        
        <!-- Hidden literals for JS charts -->
        <asp:Literal ID="litPieDataClient" runat="server" Visible="false" />
        <asp:Literal ID="litLessonLabelsClient" runat="server" Visible="false" />
        <asp:Literal ID="litLessonViewsClient" runat="server" Visible="false" />
        <asp:Literal ID="litCorrectIncorrectClient" runat="server" Visible="false" />
        <asp:Literal ID="LitCompletionClient" runat="server" Visible="true" />
        
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

    <script type="text/javascript">
        // Chart.js Configuration
        Chart.defaults.color = '#ffffff';
        Chart.defaults.borderColor = '#444444';
        Chart.defaults.backgroundColor = 'transparent';

        // Wait for page to load
        document.addEventListener('DOMContentLoaded', function () {
            drawCharts();
        });

        function drawCharts() {
            drawPieChart();
            drawCompletionChart();
            drawLessonBarChart();
            drawAnswerAccuracyChart();
        }

        function drawPieChart() {
            try {
                const pieDataText = '<%= litPieDataClient.Text %>';
                console.log('Pie data:', pieDataText);

                if (pieDataText && pieDataText.trim() !== '') {
                    const pieData = pieDataText.split(',').map(item => parseInt(item.trim()));

                    if (pieData.length >= 2 && !isNaN(pieData[0]) && !isNaN(pieData[1])) {
                        const ctx = document.getElementById('pieChart').getContext('2d');
                        new Chart(ctx, {
                            type: 'pie',
                            data: {
                                labels: ['Active Users', 'Inactive Users'],
                                datasets: [{
                                    data: pieData,
                                    backgroundColor: ['#FFD700', '#EEA400'],
                                    borderWidth: 2,
                                    borderColor: '#333'
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: {
                                        position: 'bottom',
                                        labels: {
                                            color: '#ffffff',
                                            font: {
                                                family: 'Poppins',
                                                size: 12
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    }
                }
            } catch (e) {
                console.error('Error drawing pie chart:', e);
            }
        }

        function drawCompletionChart() {
            try {
                const completionDataText = '<%= LitCompletionClient.Text %>';
                console.log('Completion data:', completionDataText);

                if (completionDataText && completionDataText.trim() !== '') {
                    const completionData = completionDataText.split(',').map(item => parseInt(item.trim()));

                    if (completionData.length >= 2 && !isNaN(completionData[0]) && !isNaN(completionData[1])) {
                        // If both values are 0, show a default message chart
                        if (completionData[0] === 0 && completionData[1] === 0) {
                            completionData[0] = 1; // Show a small slice for "No data"
                            var labels = ['No completion data available'];
                            var colors = ['#666666'];
                        } else {
                            var labels = ['Completed All Courses', 'Completed Some Courses'];
                            var colors = ['#FFD700', '#8b0000'];
                        }

                        const ctx = document.getElementById('completionChart').getContext('2d');
                        new Chart(ctx, {
                            type: 'doughnut',
                            data: {
                                labels: labels,
                                datasets: [{
                                    data: completionData,
                                    backgroundColor: colors,
                                    borderWidth: 2,
                                    borderColor: '#333'
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: {
                                        position: 'bottom',
                                        labels: {
                                            color: '#ffffff',
                                            font: {
                                                family: 'Poppins',
                                                size: 12
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    }
                } else {
                    // If no data at all, create a placeholder chart
                    const ctx = document.getElementById('completionChart').getContext('2d');
                    new Chart(ctx, {
                        type: 'doughnut',
                        data: {
                            labels: ['No data available'],
                            datasets: [{
                                data: [1],
                                backgroundColor: ['#666666'],
                                borderWidth: 2,
                                borderColor: '#333'
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            plugins: {
                                legend: {
                                    position: 'bottom',
                                    labels: {
                                        color: '#ffffff',
                                        font: {
                                            family: 'Poppins',
                                            size: 12
                                        }
                                    }
                                }
                            }
                        }
                    });
                }
            } catch (e) {
                console.error('Error drawing completion chart:', e);
                // Create an error chart as fallback
                const ctx = document.getElementById('completionChart').getContext('2d');
                new Chart(ctx, {
                    type: 'doughnut',
                    data: {
                        labels: ['Chart Error'],
                        datasets: [{
                            data: [1],
                            backgroundColor: ['#ff4444'],
                            borderWidth: 2,
                            borderColor: '#333'
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'bottom',
                                labels: {
                                    color: '#ffffff',
                                    font: {
                                        family: 'Poppins',
                                        size: 12
                                    }
                                }
                            }
                        }
                    }
                });
            }
        }

        function drawLessonBarChart() {
            try {
                const labelsText = '<%= litLessonLabelsClient.Text %>';
                const viewsText = '<%= litLessonViewsClient.Text %>';
                
                console.log('Lesson labels:', labelsText);
                console.log('Lesson views:', viewsText);
                
                if (labelsText && viewsText && labelsText.trim() !== '' && viewsText.trim() !== '') {
                    // Parse labels - handle quoted strings properly
                    const labels = [];
                    if (labelsText.includes('"')) {
                        const labelMatches = labelsText.match(/"([^"]*)"/g);
                        if (labelMatches) {
                            for (let i = 0; i < labelMatches.length; i++) {
                                labels.push(labelMatches[i].replace(/"/g, ''));
                            }
                        }
                    } else {
                        labels = labelsText.split(',').map(item => item.trim());
                    }
                    
                    const views = viewsText.split(',').map(item => parseInt(item.trim()) || 0);
                    
                    if (labels.length > 0 && views.length > 0) {
                        const ctx = document.getElementById('lessonBarChart').getContext('2d');
                        new Chart(ctx, {
                            type: 'bar',
                            data: {
                                labels: labels,
                                datasets: [{
                                    label: 'Completions',
                                    data: views,
                                    backgroundColor: '#FFD700',
                                    borderColor: '#EEA400',
                                    borderWidth: 1
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                plugins: {
                                    legend: {
                                        display: false
                                    }
                                },
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            color: '#ffffff',
                                            font: {
                                                family: 'Poppins',
                                                size: 12
                                            }
                                        },
                                        grid: {
                                            color: '#444444'
                                        }
                                    },
                                    x: {
                                        ticks: {
                                            color: '#ffffff',
                                            font: {
                                                family: 'Poppins',
                                                size: 10
                                            },
                                            maxRotation: 45
                                        },
                                        grid: {
                                            color: '#444444'
                                        }
                                    }
                                }
                            }
                        });
                    }
                }
            } catch (e) {
                console.error('Error drawing lesson bar chart:', e);
            }
        }

        function drawAnswerAccuracyChart() {
            try {
                const accuracyData = '<%= litCorrectIncorrectClient.Text %>';
                console.log('Accuracy data:', accuracyData);

                if (accuracyData && accuracyData.trim() !== '') {
                    const parts = accuracyData.split(';');
                    if (parts.length >= 3) {
                        const correctAnswers = parts[0].split(',').map(item => parseInt(item.trim()) || 0);
                        const incorrectAnswers = parts[1].split(',').map(item => parseInt(item.trim()) || 0);

                        // Parse labels - handle quoted strings properly
                        const labels = [];
                        if (parts[2].includes('"')) {
                            const labelMatches = parts[2].match(/"([^"]*)"/g);
                            if (labelMatches) {
                                for (let i = 0; i < labelMatches.length; i++) {
                                    labels.push(labelMatches[i].replace(/"/g, ''));
                                }
                            }
                        } else {
                            labels = parts[2].split(',').map(item => item.trim());
                        }

                        if (labels.length > 0) {
                            const ctx = document.getElementById('answerBarChart').getContext('2d');
                            new Chart(ctx, {
                                type: 'bar',
                                data: {
                                    labels: labels,
                                    datasets: [{
                                        label: 'High Scores (≥80)',
                                        data: correctAnswers,
                                        backgroundColor: '#4CAF50',
                                        borderColor: '#45a049',
                                        borderWidth: 1
                                    }, {
                                        label: 'Low Scores (<80)',
                                        data: incorrectAnswers,
                                        backgroundColor: '#f44336',
                                        borderColor: '#da190b',
                                        borderWidth: 1
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    plugins: {
                                        legend: {
                                            position: 'top',
                                            labels: {
                                                color: '#ffffff',
                                                font: {
                                                    family: 'Poppins',
                                                    size: 12
                                                }
                                            }
                                        }
                                    },
                                    scales: {
                                        y: {
                                            beginAtZero: true,
                                            stacked: true,
                                            ticks: {
                                                color: '#ffffff',
                                                font: {
                                                    family: 'Poppins',
                                                    size: 12
                                                }
                                            },
                                            grid: {
                                                color: '#444444'
                                            }
                                        },
                                        x: {
                                            stacked: true,
                                            ticks: {
                                                color: '#ffffff',
                                                font: {
                                                    family: 'Poppins',
                                                    size: 10
                                                },
                                                maxRotation: 45
                                            },
                                            grid: {
                                                color: '#444444'
                                            }
                                        }
                                    }
                                }
                            });
                        }
                    }
                }
            } catch (e) {
                console.error('Error drawing answer accuracy chart:', e);
            }
        }

        // Make charts responsive on window resize
        window.addEventListener('resize', function () {
            Chart.helpers.each(Chart.instances, function (instance) {
                instance.resize();
            });
        });
    </script>
</asp:Content>