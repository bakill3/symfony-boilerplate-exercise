<template>
    <main>
      <h1>Users</h1>
      <p v-if="errorMessage" class="error-message">{{ errorMessage }}</p>
      <table v-else>
        <thead>
          <tr>
            <th>ID</th>
            <th>Email</th>
            <th>Roles</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="user in users" :key="user.id">
            <td>{{ user.id }}</td>
            <td>{{ user.email }}</td>
            <td>{{ user.roles ? user.roles.join(', ') : 'No roles assigned' }}</td>
          </tr>
        </tbody>
      </table>
    </main>
  </template>
  
  <script lang="ts" setup>
  import { ref, onMounted } from "vue";
  
  const users = ref([]);
  const errorMessage = ref(null);
  
  const fetchUsers = async () => {
    try {
      users.value = await $fetch("/api/1.0/users", {
        headers: {
          Authorization: `Bearer ${localStorage.getItem("authToken")}`,
        },
      });
    } catch (error) {
      if (error.response?.status === 403) {
        errorMessage.value = "You must be an admin to view this page.";
      } else {
        console.error("Failed to fetch users:", error);
        errorMessage.value = "An error occurred while fetching the users.";
      }
    }
  };
  
  onMounted(fetchUsers);
  </script>
  
  <style scoped>
  table {
    width: 100%;
    border-collapse: collapse;
  }
  
  th,
  td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }
  
  .error-message {
    color: red;
    font-weight: bold;
    margin-bottom: 20px;
  }
  </style>
  