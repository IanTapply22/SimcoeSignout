<template>
    <v-menu v-model="filterMenuOpen" :close-on-content-click="false" location="end">
        <!-- Add filter button creation -->
        <template v-slot:activator="{ props }">
            <v-btn variant="outlined" color="blue" class="mb-3 mt-2" prepend-icon="mdi-plus" v-bind="props">
                Add Filter
            </v-btn>
        </template>

        <v-card min-width="300">
            <!-- Navigation buttons -->
            <v-list>
                <v-btn @click="activeFilterTab = 'period'" variant="text">Period</v-btn>
                <v-btn @click="activeFilterTab = 'dateRange'" variant="text">Date Range</v-btn>
                <v-btn @click="activeFilterTab = 'resource'" variant="text">Resource</v-btn>
            </v-list>
            <v-divider />

            <!-- Period tab -->
            <v-expand-transition>
                <v-card v-if="activeFilterTab === 'period'" class="v-card--reveal">
                    <v-checkbox hide-details density="comfortable" v-for="(period, i) in bookingsStore.getValidPeriods"
                        :key="i" :value="period" :label="period.toString()" v-model="bookingsStore.filteredPeriods"
                        @change='bookingsStore.fetchBookings()'></v-checkbox>
                </v-card>
            </v-expand-transition>

            <!-- Date range tab -->
            <v-expand-transition>
                <v-card v-if="activeFilterTab === 'dateRange'" class="v-card--reveal">
                    <v-text-field type="date" label="Start Date" v-model="bookingsStore.filteredDateFrom"
                        @change="bookingsStore.fetchBookings"></v-text-field>
                    <v-text-field type="date" label="End Date" v-model="bookingsStore.filteredDateTo"
                        @change="bookingsStore.fetchBookings"></v-text-field>
                </v-card>
            </v-expand-transition>

            <!-- Resource tab -->
            <v-expand-transition>
                <v-card v-if="activeFilterTab === 'resource'" class="v-card--reveal">
                    <v-checkbox hide-details density="comfortable" class="ml-2 mr-2" v-for="(resource, i) in this.store.resourceNames"
                        :key="i" :label="resource" :value="resource" v-model="this.bookingsStore.filteredResourceName"
                        @change="bookingsStore.fetchBookings"></v-checkbox>
                </v-card>
            </v-expand-transition>

            <!-- These are buttons/actions you can press/execute that are displayed on the bottom of the card -->
            <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="blue" variant="text" @click="filterMenuOpen = false">
                    Done
                </v-btn>
            </v-card-actions>
        </v-card>
    </v-menu>
</template>

<script>
import { resourcesPageStore } from '@/stores/ResourcesService';
import { bookingsStore } from '@/stores/BookingsService';

export default {
    data() {
        return {
            store: resourcesPageStore(),
            bookingsStore: bookingsStore(),
            filterMenuOpen: false,
            activeFilterTab: 'period',
        }
    },
    async mounted() {
        await this.store.fetchAllResourceNames();
    }
}
</script>

<style>
.v-card--reveal {
    bottom: 0;
    opacity: 1 !important;
    position: absolute;
    width: 100%;
}</style>
