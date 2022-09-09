<template>
  <div>
    <div class="main">
      <v-p class="pickup-art font-bold">How shall we pickup your art?</v-p>
      <div class="dropdown md:col-span-5 md:col-start-1">
        <button @click="openDrop1()" class="dropbtn">
          <span id="dropbtn1">Make a selection</span
          ><v-arrow-down class="dropdown-icon" />
        </button>
        <ul id="myDropdown1" class="dropdown-content">
          <li @click="valueChanged(1)" id="val-1" value="1">
            <strong>Home collection service (UPS)</strong
            ><span
              >We will arrange to pick up your art from a preferred
              address.</span
            ><strong>£8.00</strong>
          </li>
          <li @click="valueChanged(2)" id="val-2" value="2">
            <strong>UPS drop-off point</strong
            ><span
              >Drop your art at your most convenient UPS drop-off point.</span
            ><strong>Free</strong>
          </li>
        </ul>
      </div>
      <a
        class="drop-off font-bold"
        href="https://www.ups.com/dropoff/?loc=en_GB"
        target="_blank"
        >Find my nearest UPS drop-off point</a
      >
      <v-p class="pickup-art font-bold"
        >Need us to send you some packaging?</v-p
      >
      <div class="dropdown">
        <button @click="openDrop2()" class="dropbtn">
          <span id="dropbtn2">Make a selection</span
          ><v-arrow-down class="dropdown-icon" />
        </button>
        <ul id="myDropdown2" class="dropdown-content">
          <li name="option" @click="lowerDropdown(3)" id="val-3" value="3">
            <strong>I have my own packaging</strong
            ><span>I have secure packaging for my art.</span>
          </li>
          <li name="option" @click="lowerDropdown(4)" id="val-4" value="4">
            <strong>Cardboard tube</strong
            ><span
              >Cardboard tube is the best method if your art can be rolled
              up.</span
            >
          </li>
          <li name="option" @click="lowerDropdown(5)" id="val-5" value="5">
            <strong>Rigid envelope</strong
            ><span>Use this method if your art has to stay flat.</span>
          </li>
        </ul>
      </div>
    </div>
    <v-p class="note"
      >NOTE: Packaging is sent via Royal Mail 1st Class. Allow 2-4 business days
      for your packaging to arrive. Once we have your art in the workshop allow
      3-7 working days for standard delivery or 2-3 days for the Rush
      service.</v-p
    >
  </div>
</template>

<script>
import VueSelect from "vue-select";
import "vue-select/dist/vue-select.css";
import VP from "../Atoms/VP.vue";
import VArrowDown from "../Atoms/VArrowDown.vue";

export default {
  name: "CartPageOriginalArt",
  components: {
    VP,
    VArrowDown,
    VueSelect,
  },
  props: {
    pickupProduct: {
      type: Object,
      required: true,
    },
    cart: {
      type: Object,
      required: true,
    },
  },
  computed: {
    homePickupSelected() {
      return this.cart.pickupItem !== undefined;
    },
    price() {
      return parseFloat(this.pickupProduct.price).toFixed(2);
    },
  },
  methods: {
    async updateHomePickup() {
      if (this.homePickupSelected) {
        await this.$emit("homePickup");
      }
    },
    async valueChanged(e) {
      const val = e;
      var drop1Ele = document.getElementById("dropbtn1");
      var currentEle1 = document.getElementById("val-" + e);
      drop1Ele.textContent = currentEle1.textContent;
      await this.$emit("homePickup", val);
    },
    async lowerDropdown(e) {
      const val = e;
      var drop2Ele = document.getElementById("dropbtn2");
      var currentEle2 = document.getElementById("val-" + e);
      drop2Ele.textContent = currentEle2.textContent;
      localStorage.setItem("selectedOption", val);
    },
    openDrop1() {
      document.getElementById("myDropdown1").classList.toggle("show");
      document
        .getElementById("myDropdown1")
        .parentElement.classList.toggle("dropdown-active");
      window.onclick = function (event) {
        if (!event.target.matches(".dropbtn")) {
          var dropdowns = document.getElementsByClassName("dropdown-content");
          var i;
          for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains("show")) {
              openDropdown.classList.remove("show");
            }
          }
        }
      };
    },
    openDrop2() {
      document.getElementById("myDropdown2").classList.toggle("show");
      document
        .getElementById("myDropdown2")
        .parentElement.classList.toggle("dropdown-active");
      window.onclick = function (event) {
        if (!event.target.matches(".dropbtn")) {
          var dropdowns = document.getElementsByClassName("dropdown-content");
          var i;
          for (i = 0; i < dropdowns.length; i++) {
            var openDropdown = dropdowns[i];
            if (openDropdown.classList.contains("show")) {
              openDropdown.classList.remove("show");
            }
          }
        }
      };
    },
  },
};
</script>

<style>
.main {
  padding-left: 36px;
}
.pickup-art {
  font-size: 20px;
}
.note {
  margin: 60px 0 89px 0;
  text-align: center;
  font-size: 17px;
}
.drop-off {
  font-size: 18px;
  text-decoration: underline;
  display: block;
  margin-bottom: 68px;
}

.dropdown-icon {
  position: absolute;
  right: 32px;
  top: 50%;
  transform: translateY(-50%);
}

.dropbtn {
  font-size: 18px;
  cursor: pointer;
  text-align: left;
  letter-spacing: 2px;
  background: rgba(245, 245, 244, 0.2);
  color: black;
  border-radius: 4px;
  width: 100%;
  height: 80px;
  padding: 0 55px 0 32px;
  font-style: normal;
  font-weight: 500;
  font-size: 14px;
  line-height: 24px;
  letter-spacing: 2px;
  text-transform: uppercase;
  color: #828282;
}

.dropbtn span {
  letter-spacing: 2px;
}

.dropbtn:focus {
  outline: none;
}

.dropdown {
  position: relative;
  display: inline-block;
  width: 581px;
  margin: 20px 0;
  outline: none;
  border: 1px solid rgba(29, 32, 25, 0.2);
  border-radius: 4px;
}

.dropdown-content {
  display: none;
  position: absolute;
  background: #fcfcfc;
  overflow: auto;
  z-index: 1;
  list-style: none;
  width: 581px;
  margin: 0;
  padding: 0;
  right: -1px;
  border: 1px solid rgba(29, 32, 25, 0.2);
}

.dropdown-content li {
  padding: 15px;
  cursor: pointer;
  font-size: 18px;
}

.dropdown-content li strong,
.dropdown-content li span {
  display: block;
  line-height: 26px;
  font-size: 18px;
}

.dropdown-content li:hover {
  background-color: black;
  color: white;
  transition-duration: 0.3s;
}

.show {
  display: block;
}

.dropdown-active .dropbtn .dropdown-icon {
  transform: rotate(180deg);
  transition-duration: 0.2s;
}

@media all and (max-width: 480px) {
  .dropdown {
    width: 323px;
  }
  .dropbtn {
    width: 323px;
  }
  .dropdown-content {
    width: 323px;
  }
  .main {
    padding: 20px;
  }
}
@media all and (max-width: 380px) {
  .dropdown {
    width: 323px;
  }
  .dropbtn {
    width: 323px;
  }
  .dropdown-content {
    width: 323px;
  }
  .main {
    padding: 20px;
  }
}
@media all and (max-width: 360px) {
  .dropdown {
    width: 323px;
  }
  .dropbtn {
    width: 323px;
  }
  .dropdown-content {
    width: 323px;
  }
  .main {
    padding: 20px;
  }
}
</style>
