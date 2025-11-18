/*
 * Copyright (c) 2021, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <ti/driverlib/driverlib.h>
#include <ti/driverlib/m0p/dl_core.h>

#define POWER_STARTUP_DELAY                                                (16)

/* Map PA 10,11,12,13 to pinCMx 21,22,34,35 */
#define GPIO_PIN_10_IOMUX                               (IOMUX_PINCM21)
#define GPIO_PIN_11_IOMUX                               (IOMUX_PINCM22)
#define GPIO_PIN_12_IOMUX                               (IOMUX_PINCM34)
#define GPIO_PIN_13_IOMUX                               (IOMUX_PINCM35)

/* Map PB 22,26,27 to pinCMx 50,57,58 */
#define GPIO_PIN_22_IOMUX                               (IOMUX_PINCM50)
#define GPIO_PIN_26_IOMUX                               (IOMUX_PINCM57)
#define GPIO_PIN_27_IOMUX                               (IOMUX_PINCM58)

unsigned int BINARY_IN;

void DL_init(void);
void LED_flash(void);

int main(void)
{
    /* Initialize CPU, power on GPIO, initialize pins as digital outputs */
    DL_init();

    /* Set initial value of 4-bit BINARY_IN */
    BINARY_IN = 0b1111;
    unsigned int OUT;
    while (1) {
        /* Flash LED to indicate that the code has been successfully flashed and is running in loop */
        LED_flash();

        /* Left-shift BINARY_IN by 10 bits to move data to positions corresponding to PA 10(LSB),11,12,13(MSB) */
        OUT = BINARY_IN<<10;

        /* Write 4-bit BINARY_IN to PA 10,11,12,13 */
        GPIOA->DOUT31_0 = OUT;

        /* Delay by 10 cycles */
        delay_cycles(10);
    }
}

void DL_init(void)
{
    /* Reset GPIOA peripheral */
    GPIOA->GPRCM.RSTCTL =
            (GPIO_RSTCTL_KEY_UNLOCK_W | GPIO_RSTCTL_RESETSTKYCLR_CLR |
                GPIO_RSTCTL_RESETASSERT_ASSERT);

    /* Reset GPIOB peripheral */
    GPIOB->GPRCM.RSTCTL =
            (GPIO_RSTCTL_KEY_UNLOCK_W | GPIO_RSTCTL_RESETSTKYCLR_CLR |
                GPIO_RSTCTL_RESETASSERT_ASSERT);

    /* Power on GPIOA */
    GPIOA->GPRCM.PWREN = (GPIO_PWREN_KEY_UNLOCK_W | GPIO_PWREN_ENABLE_ENABLE);

    /* Power on GPIOB */
    GPIOB->GPRCM.PWREN = (GPIO_PWREN_KEY_UNLOCK_W | GPIO_PWREN_ENABLE_ENABLE);

    /* Delay by 16 cycles upon startup */
    delay_cycles(POWER_STARTUP_DELAY);

    /* Configure PA 10,11,12,13 as GPIO outputs */
    IOMUX->SECCFG.PINCM[GPIO_PIN_10_IOMUX] =
        (IOMUX_PINCM_PC_CONNECTED | ((uint32_t) 0x00000001));
    IOMUX->SECCFG.PINCM[GPIO_PIN_11_IOMUX] =
        (IOMUX_PINCM_PC_CONNECTED | ((uint32_t) 0x00000001));
    IOMUX->SECCFG.PINCM[GPIO_PIN_12_IOMUX] =
        (IOMUX_PINCM_PC_CONNECTED | ((uint32_t) 0x00000001));
    IOMUX->SECCFG.PINCM[GPIO_PIN_13_IOMUX] =
        (IOMUX_PINCM_PC_CONNECTED | ((uint32_t) 0x00000001));

    /* Clear registers PA 10,11,12,13 */
    GPIOA->DOUTCLR31_0 = DL_GPIO_PIN_10 |
                        DL_GPIO_PIN_11 |
                        DL_GPIO_PIN_12 |
                        DL_GPIO_PIN_13;

    /* Enable outputs on PA 10,11,12,13 */
    GPIOA->DOESET31_0 = DL_GPIO_PIN_10 |
                        DL_GPIO_PIN_11 |
                        DL_GPIO_PIN_12 |
                        DL_GPIO_PIN_13;

    /* Configure PB 22,26,27 as LED outputs */
    IOMUX->SECCFG.PINCM[GPIO_PIN_22_IOMUX] =
       (IOMUX_PINCM_PC_CONNECTED | ((uint32_t) 0x00000001));
    IOMUX->SECCFG.PINCM[GPIO_PIN_26_IOMUX] =
       (IOMUX_PINCM_PC_CONNECTED | ((uint32_t) 0x00000001));
    IOMUX->SECCFG.PINCM[GPIO_PIN_27_IOMUX] =
       (IOMUX_PINCM_PC_CONNECTED | ((uint32_t) 0x00000001));

    /* Clear registers PB 22,26,27 */
    GPIOB->DOUTCLR31_0 = DL_GPIO_PIN_22 |
                       DL_GPIO_PIN_26 |
                       DL_GPIO_PIN_27;

    /* Enable outputs on PB 22,26,27 */
    GPIOB->DOESET31_0 = DL_GPIO_PIN_22 |
                       DL_GPIO_PIN_26 |
                       DL_GPIO_PIN_27;

    /* Set the target frequency of the System Oscillator (SYSOSC) */
    DL_Common_updateReg(&SYSCTL->SOCLOCK.SYSOSCCFG, (uint32_t) DL_SYSCTL_SYSOSC_FREQ_BASE,
              SYSCTL_SYSOSCCFG_FREQ_MASK);

    /* Set the brown-out reset (BOR) threshold level */
    SYSCTL->SOCLOCK.BORTHRESHOLD = (uint32_t) DL_SYSCTL_BOR_THRESHOLD_LEVEL_0;
}

void LED_flash(void)
{
    unsigned int OUTSTATUS = 0b00000000010000000000000000000000;
    GPIOB->DOUT31_0 = OUTSTATUS;

    delay_cycles(5000000);

    OUTSTATUS = 0b00000000000000000000000000000000;
    GPIOB->DOUT31_0 = OUTSTATUS;

    delay_cycles(2500000);

    OUTSTATUS = 0b00000000010000000000000000000000;
    GPIOB->DOUT31_0 = OUTSTATUS;

    delay_cycles(5000000);

    OUTSTATUS = 0b00000000000000000000000000000000;
    GPIOB->DOUT31_0 = OUTSTATUS;

    delay_cycles(20000000);
}
