<template>
    <main>
      <h1>Dashboard</h1>
      <div class="dashboard-card">
        <p>User Score: <strong>{{ dashboardData.score }}</strong></p>
        <p>Transactions Without Validated Location: <strong>{{ dashboardData.unvalidatedLocations }}</strong></p>
      </div>
    </main>
  </template>
  
  <script lang="ts" setup>
  import { ref, onMounted } from "vue";
  
  const dashboardData = ref({ score: 0, unvalidatedLocations: 0 });
  
  const fetchDashboardData = async () => {
    try {
      dashboardData.value = await $fetch("/api/1.0/dashboard", {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("authToken")}`,
        },
      });
    } catch (error) {
      console.error("Error fetching dashboard data:", error);
    }
  };
  
  onMounted(fetchDashboardData);
  </script>
  
  <style scoped>
  .dashboard-card {
    background: #f9f9f9;
    padding: 20px;
    border: 1px solid #ddd;
    border-radius: 8px;
    max-width: 400px;
    margin: 20px auto;
    text-align: center;
  }
  </style>
  