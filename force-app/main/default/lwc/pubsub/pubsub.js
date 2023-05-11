const store = {}

const subscribe = (eventName, callback) => {
    if (!store[eventName]) {
        store[eventName] = new Set();
    }
    store[eventName].add(callback)
}
console.log(store);

const publish = (eventName, payload) => {
    if (store[eventName]) {
        store[eventName].forEach(callback => {
            try {
                callback(payload)
            } catch (error) {   
                console.error(error)
            }
        })
    }
}

const unsubscribe = (eventName, callback) => {
    if (store[eventName]) {
        store[eventName].delete(callback)
    }
}

const displayStore = () =>{
    console.log(JSON.stringify(store));
}

export default {
    subscribe,
    unsubscribe,
    publish,
    displayStore
}
