<template>
  <main>
    <h1>Transactions</h1>
    <table class="table table-striped">
      <thead>
        <tr>
          <th>Date / Time</th>
          <th>Amount</th>
          <th>Payment Label</th>
          <th>Localization</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="transaction in transactions" :key="transaction.id">
          <td>{{ transaction.date }}</td>
          <td>{{ transaction.amount }}</td>
          <td>{{ transaction.payment_label }}</td>
          <td>
            <div v-if="transaction.location">
              {{ transaction.location }}
            </div>
            <div v-else>
              <button
                class="btn btn-primary"
                @click="openModal(transaction.id)"
              >
                Identify this place
              </button>
            </div>
          </td>
        </tr>
      </tbody>
    </table>

    <div v-if="showModal" class="modal">
      <h2>Select Location</h2>
      <div id="map" style="width: 100%; height: 400px;"></div>
      <p v-if="selectedAddress">Selected Address: {{ selectedAddress }}</p>
      <button class="btn btn-success" @click="saveLocation">Save Location</button>
      <button class="btn btn-danger" @click="closeModal">Cancel</button>
    </div>
  </main>
</template>

<script lang="ts" setup>
import { ref, onMounted } from "vue";

const transactions = ref([]);
const showModal = ref(false);
const selectedTransactionId = ref(null);
const selectedAddress = ref(null);
const selectedLatitude = ref(null);
const selectedLongitude = ref(null);
let map = null;
let marker = null;

const fetchTransactions = async () => {
  transactions.value = await $fetch("/api/1.0/transactions", {
    headers: {
      Authorization: `Bearer ${localStorage.getItem("authToken")}`,
    },
  });
};

const openModal = (transactionId) => {
  const transaction = transactions.value.find((t) => t.id === transactionId);
  if (transaction) {
    selectedLatitude.value = transaction.gps_latitude;
    selectedLongitude.value = transaction.gps_longitude;
  }

  selectedTransactionId.value = transactionId;
  showModal.value = true;

  setTimeout(() => initializeMap(), 0);
};

const closeModal = () => {
  showModal.value = false;
  selectedAddress.value = null;
  selectedLatitude.value = null;
  selectedLongitude.value = null;
  map = null;
  marker = null;
};

const initializeMap = () => {
  const mapElement = document.getElementById("map");
  if (!mapElement) return;

  map = new google.maps.Map(mapElement, {
    center: {
      lat: selectedLatitude.value || 40.7128,
      lng: selectedLongitude.value || -74.006,
    },
    zoom: 12,
  });

  marker = new google.maps.Marker({
    position: map.getCenter(),
    map: map,
    draggable: true,
  });

  google.maps.event.addListener(marker, "dragend", async () => {
    const position = marker.getPosition();
    const geocoder = new google.maps.Geocoder();
    const response = await geocoder.geocode({ location: position });

    if (response.results && response.results.length > 0) {
      selectedAddress.value = response.results[0].formatted_address;
      selectedLatitude.value = position.lat();
      selectedLongitude.value = position.lng();
    }
  });
};

const saveLocation = async () => {
  if (!selectedAddress.value || selectedLatitude.value === null || selectedLongitude.value === null) {
    alert("Please select a location!");
    return;
  }

  await $fetch(`/api/1.0/transactions/${selectedTransactionId.value}/location`, {
    method: "POST",
    body: {
      location: selectedAddress.value,
      gps_latitude: selectedLatitude.value,
      gps_longitude: selectedLongitude.value,
    },
  });

  const updatedTransaction = transactions.value.find(
    (t) => t.id === selectedTransactionId.value
  );
  if (updatedTransaction) {
    updatedTransaction.location = selectedAddress.value;
  }

  alert("Location saved successfully!");
  closeModal();
};

onMounted(fetchTransactions);
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

.modal {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  background: white;
  padding: 20px;
  border: 1px solid #ccc;
  width: 90%;
  max-width: 600px;
  z-index: 1000;
}
</style>
