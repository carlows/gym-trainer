import { ref, computed } from "vue";
// 1. Define the state OUTSIDE the function to create a "Singleton"
// This ensures that if Component A logs in, Component B sees the change immediately.
const userIdentifier = ref<string | null>(localStorage.getItem("session_id"));

export function useAuth() {
  const isAuthenticated = computed(() => !!userIdentifier.value);

  const login = (id: string) => {
    userIdentifier.value = id;
    localStorage.setItem("session_id", id);
  };

  const logout = () => {
    userIdentifier.value = null;
    localStorage.removeItem("session_id");
  };

  return {
    userIdentifier,
    isAuthenticated,
    login,
    logout,
  };
}
