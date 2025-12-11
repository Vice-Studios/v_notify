const container = document.getElementById("notifications");

window.addEventListener("message", (event) => {
    const data = event.data;
    if (!data.action) return;

    if (data.action === "notify") {
        createNotification(
            data.type,
            data.title || getDefaultTitle(data.type),
            data.message,
            data.duration,
            data.icon
        );
    }
});

function getDefaultTitle(type) {
    return {
        success: "Success",
        error: "Error",
        warning: "Warning",
        info: "Info"
    }[type] || "Info";
}

function createNotification(type, title, message, duration, icon) {
    playNotifySound(type);

    const notification = document.createElement("div");
    notification.classList.add("notification", type);

    /* ICON */
    if (icon) {
        const iconEl = document.createElement("i");
        iconEl.className = "notification-icon " + icon;
        notification.appendChild(iconEl);
    }

    /* TEXT CONTAINER — KEEPING ALL YOUR INLINE STYLES */
    const content = document.createElement("div");

    Object.assign(content.style, {
        display: "flex",
        flexDirection: "column",
        zIndex: "5",
        position: "absolute",
        left: "85px",
        top: "35%",
        width: "195px",
        height: "60px"
    });

    const titleEl = document.createElement("div");
    titleEl.classList.add("notification-title");
    titleEl.textContent = title;

    const messageEl = document.createElement("div");
    messageEl.classList.add("notification-message");
    messageEl.textContent = message;

    content.appendChild(titleEl);
    content.appendChild(messageEl);

    /* CLOSE BUTTON */
    const closeBtn = document.createElement("div");
    closeBtn.classList.add("notification-close");
    closeBtn.innerHTML = "&times;";
    closeBtn.onclick = () => destroyNotification(notification);

    /* STACK LIMIT */
    if (container.children.length >= (window.maxNotifications || 5)) {
        destroyNotification(container.firstChild);
    }

    notification.appendChild(content);
    notification.appendChild(closeBtn);
    container.appendChild(notification);

    /* AUTO REMOVE */
    setTimeout(() => destroyNotification(notification), duration);
}

function destroyNotification(notification) {
    notification.style.animation = "slideOut 0.25s forwards";
    setTimeout(() => notification.remove(), 240);
}

function playNotifySound(type) {
    const audioId = {
        error: "notify-sound-error",
        success: "notify-sound-success",
        warning: "notify-sound-warning",
        info: "notify-sound-info"
    }[type];

    if (!audioId) return;

    const audio = document.getElementById(audioId);
    if (audio) {
        audio.currentTime = 0;
        audio.volume = window.soundVolume ?? 0.35;
        audio.play().catch(() => {});
    }
}