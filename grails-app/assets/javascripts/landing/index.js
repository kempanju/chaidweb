'use strict'

const appToolBar = new Vue({
    el: '#appToolBar',
    mounted: function(){
        console.log('app tool bar started');
    },
    data: {
        
    },
    methods: {
        
    },
    computed: {
        
    }
});

const howToModal = new Vue({
    el: '#loginModal',
    data: {
        user: {
            username: '',
            password: ''
        },
    },
    methods: {
        login: function(){
            const loginForm = this.$refs.loginForm;
            console.log(loginForm);
            console.log('login clicked');
        },
    }
});
