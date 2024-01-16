// SPDX-License-Identifier: BSD-3-Clause
// Copyright (c) 2024, Alex Taradov <alex@taradov.com>. All rights reserved.

#ifndef _HAL_CONFIG_H_
#define _HAL_CONFIG_H_

/*- Includes ----------------------------------------------------------------*/
#include "samd21.h"
#include "hal_gpio.h"

/*- Definitions -------------------------------------------------------------*/
#define HAL_BOARD_GENERIC

#if defined(HAL_BOARD_CUSTOM)
  // Externally supplied board configuration takes precedence
  #include HAL_BOARD_CUSTOM

#elif defined(HAL_BOARD_GENERIC)
  #define HAL_CONFIG_ENABLE_VCP
  #define DAP_CONFIG_ENABLE_JTAG

  HAL_GPIO_PIN(SWCLK_TCK,          A, 4)
  HAL_GPIO_PIN(SWDIO_TMS,          A, 3)
  HAL_GPIO_PIN(TDI,                A, 6)
  HAL_GPIO_PIN(TDO,                A, 5)
  HAL_GPIO_PIN(nRESET,             A, 7)

  HAL_GPIO_PIN(VCP_STATUS,         A, 15);
  HAL_GPIO_PIN(DAP_STATUS,         A, 16);
  HAL_GPIO_PIN(BOOT_ENTER,         A, 31);

  HAL_GPIO_PIN(UART_TX,            A, 0);
  HAL_GPIO_PIN(UART_RX,            A, 1);

  #define UART_SERCOM              SERCOM1
  #define UART_SERCOM_PMUX         PORT_PMUX_PMUXE_D_Val
  #define UART_SERCOM_GCLK_ID      SERCOM1_GCLK_ID_CORE
  #define UART_SERCOM_APBCMASK     PM_APBCMASK_SERCOM1
  #define UART_SERCOM_IRQ_INDEX    SERCOM1_IRQn
  #define UART_SERCOM_IRQ_HANDLER  irq_handler_sercom1
  #define UART_SERCOM_TXPO         0 // PAD[0]
  #define UART_SERCOM_RXPO         1 // PAD[1]

#else
  #error No board defined
#endif

#endif // _HAL_CONFIG_H_
