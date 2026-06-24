// Mobile sidebar toggle
const mobileMenuBtn = document.getElementById('mobile-menu-btn');
const sidebar = document.getElementById('sidebar');
const sidebarOverlay = document.getElementById('sidebar-overlay');

// Toggle sidebar on mobile
mobileMenuBtn.addEventListener('click', () => {
    sidebar.classList.toggle('hidden');
    sidebarOverlay.classList.toggle('hidden');
});

// Close sidebar when clicking overlay
sidebarOverlay.addEventListener('click', () => {
    sidebar.classList.add('hidden');
    sidebarOverlay.classList.add('hidden');
});

// Close sidebar when clicking a link (mobile)
const navLinks = sidebar.querySelectorAll('.nav-link');
navLinks.forEach(link => {
    link.addEventListener('click', () => {
        if (window.innerWidth < 768) {
            sidebar.classList.add('hidden');
            sidebarOverlay.classList.add('hidden');
        }
    });
});

// Handle window resize
window.addEventListener('resize', () => {
    if (window.innerWidth >= 768) {
        sidebar.classList.remove('hidden');
        sidebarOverlay.classList.add('hidden');
    }
});

// Submenu toggle functionality
document.addEventListener('DOMContentLoaded', () => {
    const toggleButtons = document.querySelectorAll('.toggle-submenu');
    
    toggleButtons.forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            
            const menuItemGroup = button.closest('.menu-item-group');
            const submenu = menuItemGroup.querySelector('.submenu');
            const chevronIcon = button.querySelector('.fa-chevron-down');
            
            // Toggle submenu visibility
            submenu.classList.toggle('hidden');
            
            // Rotate chevron icon
            chevronIcon.style.transform = submenu.classList.contains('hidden') 
                ? 'rotate(0deg)' 
                : 'rotate(180deg)';
        });
    });
});
