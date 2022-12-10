# frozen_string_literal: true

class RkmainController < ApplicationController
  before_action :set_input, only: :show
  before_action :check_input, only: :show

  def input; end

  def show
    # обработка согласно заданию
    # массив вещественных чисел (могут быть отрицательные числа)
    @input_arr = @input.split(' ').map(&:to_f)

    # поиск минимального числа
    @input_arr_min = @input_arr.min

    # поиск индекса последнего отрицательно числа
    @last_negative_ind = nil
    @last_negative_ind_ex = @input_arr.reverse.find_index(&:negative?)
    @last_negative_ind = (@last_negative_ind_ex + 1) * -1 if @last_negative_ind_ex

    @modified = @input_arr.clone
    if @last_negative_ind
      @modified[@last_negative_ind] = @input_arr_min
      # 1 2 3 4 -3 -5 -1 9
      # hi
    else
      @modified = [@input_arr_min] + @input_arr
    end
    @modified = @modified.join(' ')
  end

  private

  def set_input
    @input = params[:query]
  end

  def check_input
    unless @input.match?(/^[-. \d]+$/) && @input.match?(/\d/) \
      && !@input.match?(/\d-/) \
      && !@input.match?(/[.][^\d]/) \
      && !@input.match?(/[.]$/) \
      && !@input.match?(/^[.]/) \
      && !@input.match?(/-[^\d]/) \
      && !@input.match?(/-$/) \
      && !@input.match?(/^-/) \
      && !@input.match?(/-[.]/) \
      && !@input.match?(/[.]-/) \
      && !@input.match?(/--+/) \
      && !@input.match?(/[.][.]+/)
      check_input_all
    end
  end

  def check_input_all
    @ptrn_list = [
      /^\s+$/,
      /,/,
      /[[:alpha:]]/,
      /\d-/,
      /[.][^\d]/,
      /[.]$/,
      /^[.]/,
      /-[^\d]/,
      /-$/,
      /^-/,
      /-[.]/,
      /[.]-/,
      /--+/,
      /[.][.]+/,
      /^.*$/
    ]
    @error_messages = [
      'Введите числа!',
      'Без запятых!',
      'Без букв!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Ошибка в обозначении числа!',
      'Неизвестная ошибка! Возможно вы ввели знаки "-" и "." неправильно!'
    ]

    @code = 0

    if @err_ind = @ptrn_list.find_index { |ptrn| @ind = ptrn.match(@input) }
      @code = @err_ind + 1
      @err_msg = @error_messages[@err_ind]
      @ind = @ind[0]
    end

    redirect_to(root_path, notice: [@code, @err_msg, @ind]) unless @code.zero?
  end
end
